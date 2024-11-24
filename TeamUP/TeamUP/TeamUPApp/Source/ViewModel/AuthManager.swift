//
//  AuthManager.swift
//  TeamUP
//
//  Created by 강희창 on 11/16/24.
//

import SwiftUI
import KeychainSwift
import Alamofire

struct LoginResponse: Decodable {
    let token: AuthManager.Token
    let user: User
}

@Observable
final class AuthManager {
    private let keychain = KeychainSwift()
    private(set) var user: User?
    private(set) var isValied: Bool = false

    private var defaultURL: URLComponents = URLComponents()

    init() {
        if let urlString = Bundle.main.infoDictionary?["UrlString"],
            let urlS = urlString as? String
        {
            defaultURL.scheme = "https"
            defaultURL.host = urlS
        }
    }

    // Keychain 키 정의
    private let accessTokenKey = "access_token"
    private let refreshTokenKey = "refresh_token"

    struct Token: Codable {
        let accessToken: String
        let refreshToken: String

        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case refreshToken = "refresh_token"
        }
    }
    // 인증 관련 상태 관리
    var isAuthenticated: Bool = false

    // MARK: - Token 저장 메서드
    func saveToken(_ token: Token) {
        // JWT를 Keychain에 저장
        keychain.set(
            token.accessToken, forKey: accessTokenKey,
            withAccess: .accessibleAfterFirstUnlock)
        keychain.set(
            token.refreshToken, forKey: refreshTokenKey,
            withAccess: .accessibleAfterFirstUnlock)
        isAuthenticated = true  // 사용자 인증 상태 업데이트
    }

    // MARK: - Token 가져오기 메서드
    func getToken(key: String) -> String? {
        return keychain.get(key)
    }

    // MARK: - Token 삭제 메서드
    func clearToken() {
        keychain.delete(accessTokenKey)
        keychain.delete(refreshTokenKey)
        isAuthenticated = false  // 사용자 인증 상태 초기화
    }

    // MARK: - 회원가입
    func signUp(user: User, password: String) async throws {
        defaultURL.path = "/user/signup"
        guard let url = defaultURL.url else {
            return
        }

        let parameters: [String: Any] = [
            "email": user.email,
            "nickname": user.nickname,
            "profile_image_name": user.profileImageName,
            "password": password,
        ]

        AF.request(
            url, method: .post, parameters: parameters,
            encoding: JSONEncoding.default
        ).response { response in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - 서버 로그인 요청
    func login(
        email: String, password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        let loginEndpoint = "https://protectmeios.xyz/user/signin"
        let parameters: [String: String] = [
            "id": email,
            "password": password,
        ]

        AF.request(
            loginEndpoint, method: .post, parameters: parameters,
            encoding: JSONEncoding.default
        )
        .responseDecodable(of: LoginResponse.self) { response in
            debugPrint("Response JSON: \(response)")  // 서버 응답 디버깅

            switch response.result {
            case .success(let data):
                self.saveToken(data.token)
                self.user = data.user  // 사용자 정보 저장
                self.isAuthenticated = true  // 인증 상태 업데이트

                // 사용자 정보 콘솔에 출력
                print("로그인 성공: 사용자 정보")
                print("ID: \(data.user.id)")
                print("Email: \(data.user.email)")
                print("Nickname: \(data.user.nickname)")
                print("Profile Image Name: \(data.user.profileImageName)")

                completion(.success(data.user))
            case .failure(let error):
                debugPrint("Error: \(error)")
                completion(.failure(error))
            }
        }
    }

    // MARK: - 서버로 토큰 갱신 요청
    func refreshToken(completion: @escaping (Result<Void, Error>) -> Void) {
        // Keychain에서 refreshToken 가져오기
        guard let refreshToken = getToken(key: refreshTokenKey) else {
            completion(
                .failure(
                    NSError(
                        domain: "",
                        code: 401,
                        userInfo: [
                            NSLocalizedDescriptionKey:
                                "No refresh token available"
                        ]
                    )))
            return
        }

        // 서버의 토큰 갱신 엔드포인트
        let refreshEndpoint = "https://protectmeios.xyz/auth/refresh"

        // 요청에 필요한 파라미터
        let parameters: [String: String] = [
            "refresh_token": refreshToken
        ]

        // Alamofire 요청
        AF.request(
            refreshEndpoint, method: .post, parameters: parameters,
            encoder: JSONParameterEncoder.default
        )
        .validate()  // 서버 응답 검증
        .responseDecodable(of: Token.self) { response in
            switch response.result {
            case .success(let newToken):
                // 갱신된 토큰 저장
                self.saveToken(newToken)
                completion(.success(()))
            case .failure(let error):
                // 갱신 실패 시 Keychain에서 기존 토큰 삭제
                self.clearToken()
                completion(.failure(error))
            }
        }
    }

    func refreshTokenIfNeeded(completion: @escaping (Bool) -> Void) {
        guard let refreshToken = getToken(key: refreshTokenKey) else {
            print("리프레쉬 토큰이 없습니다.")
            completion(false)
            return
        }

        defaultURL.path = "/auth/refresh"  // 리프레쉬 토큰을 사용하는 엔드포인트

        guard let url = defaultURL.url else {
            print("Invalid URL")
            completion(false)
            return
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(refreshToken)"
        ]

        AF.request(url, method: .post, headers: headers)
            .responseDecodable(of: [String: String].self) { response in
                switch response.result {
                case .success(let newToken):
                    self.keychain.set(
                        newToken["access_token"]!, forKey: self.accessTokenKey)
                    print("토큰 갱신 성공: \(newToken["access_token"]!)")
                    completion(true)
                case .failure(let error):
                    print(response.response?.statusCode)
                    print("토큰 갱신 실패: \(error.localizedDescription)")
                    if let res = response.response, res.statusCode == 401 {
                        self.clearToken()  // 리프레쉬 토큰도 만료되었다면 모든 인증 정보 삭제
                    }
                    completion(false)
                }
            }
    }

    // MARK: - 이메일 중복 확인
    func checkEmailAvailability(email: String) async throws -> Bool {
        var url = defaultURL
        url.path = "/check-exists/email/data"
        url.queryItems = [URLQueryItem(name: "email", value: email)]

        guard let requestURL = url.url else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }
        do {
            // 서버 응답을 [String: Bool]로 디코딩
            let response = try await AF.request(requestURL, method: .get)
                .serializingDecodable([String: Bool].self)
                .value

            // "exist" 키 확인
            if let exists = response["exist"] {
                return exists
            } else {
                throw NSError(
                    domain: "Invalid Response", code: 500,
                    userInfo: [
                        NSLocalizedDescriptionKey:
                            "Response missing 'exist' key"
                    ])
            }
        } catch {
            throw error
        }
    }

    // MARK: -  닉네임 중복 확인

    func checkNicknameAvailability(nickname: String) async throws -> Bool {
        var url = defaultURL
        url.path = "/check-exists/nickname/data"
        url.queryItems = [URLQueryItem(name: "nickname", value: nickname)]

        guard let requestURL = url.url else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }

        do {
            let response = try await AF.request(requestURL, method: .get)
                .serializingDecodable([String: Bool].self)
                .value

            if let exists = response["exist"] {
                return exists
            } else {
                throw NSError(
                    domain: "Invalid Response", code: 500, userInfo: nil)
            }
        } catch {
            throw error
        }
    }

    func logout() {
        clearToken()  // Keychain에서 토큰 삭제
        isAuthenticated = false  // 인증 상태 초기화
        print("로그아웃 완료: 토큰 삭제 및 인증 상태 초기화")
    }
    
    func deleteAccount() {
        print("회원탈퇴 완료")
    }

    func hasAccessToken() -> Bool {
        return keychain.get(accessTokenKey) != nil
    }

    // 자동 로그인
    func fetchUserInfo(completion: @escaping (Result<User, Error>) -> Void) {
        defaultURL.path = "/user/signin/auto"  // 엔드포인트 경로 설정

        guard let url = defaultURL.url else {
            print("Invalid URL")
            completion(
                .failure(
                    NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        guard let accessToken = getToken(key: accessTokenKey) else {
            print("Access token is missing")
            completion(
                .failure(
                    NSError(
                        domain: "Missing Access Token", code: 401, userInfo: nil
                    )))
            return
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]

        AF.request(url, method: .post, headers: headers)
            .validate()
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let user):
                    self.user = user
                    print(self.user)
                    self.isAuthenticated = true
                    completion(.success(user))
                case .failure(let error):
                    if let res = response.response, res.statusCode == 401 {
                        // 토큰 만료 상태라면 갱신 시도
                        print("토큰 만료: 리프레쉬 토큰으로 갱신 시도")
                        self.refreshTokenIfNeeded { success in
                            if success {
                                // 갱신 성공 시 사용자 정보를 다시 가져옴
                                self.fetchUserInfo(completion: completion)
                            } else {
                                // 갱신 실패
                                self.isAuthenticated = false
                                completion(.failure(error))
                            }
                        }
                    } else {
                        self.isAuthenticated = false
                        completion(.failure(error))
                    }
                }
            }
    }

    func updateUserProfile(nickname: String, bio: String, /*interests: [String], links: [String],*/ completion: @escaping (Result<String, Error>) -> Void) async throws {
        defaultURL.path = "/user"
        
        guard let url = defaultURL.url else { throw HttpError.urlError }
        guard let key = keychain.get(accessTokenKey) else { throw HttpError.keyError }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(key)"
        ]
        
        let parameters: [String: Any] = [
//            "nickname": nickname,
            "bio": bio,
//            "interests": interests,
//            "links": links
        ]
        
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()  // 서버 응답 검증
            .responseDecodable(of: [String : String].self) { response in
                switch response.result {
                case .success(let updatedUser):
                    if let data = updatedUser["message"] as? String {
                        print(data)
                        completion(.success(data))
                    }
                case .failure(let error):
                        completion(.failure(error))
                }
            }
    }


}

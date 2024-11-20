//
//  AuthManager.swift
//  TeamUP
//
//  Created by 강희창 on 11/16/24.
//

import SwiftUI
import Alamofire
import KeychainSwift

struct LoginResponse: Decodable {
    let token: AuthManager.Token
    let user: User
}

final class AuthManager: ObservableObject {
    private let keychain = KeychainSwift()
    @Published private(set) var user: User?
    @Published private(set) var isValied: Bool = false
    
    
    private var defaultURL: URLComponents = URLComponents()
    
    init() {
        if let urlString = Bundle.main.infoDictionary?["UrlString"], let urlS = urlString as? String {
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
    @Published var isAuthenticated: Bool = false
    
    // MARK: - Token 저장 메서드
    func saveToken(_ token: Token) {
        // JWT를 Keychain에 저장
        keychain.set(token.accessToken, forKey: accessTokenKey, withAccess: .accessibleAfterFirstUnlock)
        keychain.set(token.refreshToken, forKey: refreshTokenKey, withAccess: .accessibleAfterFirstUnlock)
        isAuthenticated = true // 사용자 인증 상태 업데이트
    }
    
    // MARK: - Token 가져오기 메서드
    func getToken(key: String) -> String? {
        return keychain.get(key)
    }
    
    // MARK: - Token 삭제 메서드
    func clearToken() {
        keychain.delete(accessTokenKey)
        keychain.delete(refreshTokenKey)
        isAuthenticated = false // 사용자 인증 상태 초기화
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
            "password" : password
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response  in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - 서버 로그인 요청
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let loginEndpoint = "https://protectmeios.xyz/user/signin"
        let parameters: [String: String] = [
            "id": email,
            "password": password
        ]
        
        AF.request(loginEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: LoginResponse.self) { response in
                debugPrint("Response JSON: \(response)") // 서버 응답 디버깅
                
               switch response.result {
                case .success(let data):
                    self.saveToken(data.token)
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
            completion(.failure(NSError(
                domain: "",
                code: 401,
                userInfo: [NSLocalizedDescriptionKey: "No refresh token available"]
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
        AF.request(refreshEndpoint, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .validate() // 서버 응답 검증
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
                throw NSError(domain: "Invalid Response", code: 500, userInfo: [NSLocalizedDescriptionKey: "Response missing 'exist' key"])
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
                throw NSError(domain: "Invalid Response", code: 500, userInfo: nil)
            }
        } catch {
            throw error
        }
    }
    
    func logout() {
        clearToken() // Keychain에서 토큰 삭제
        isAuthenticated = false // 인증 상태 초기화
        print("로그아웃 완료: 토큰 삭제 및 인증 상태 초기화")
    }
    
    func hasAccessToken() -> Bool {
        return keychain.get(accessTokenKey) != nil
    }
}

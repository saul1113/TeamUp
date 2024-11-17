//
//  AuthManager.swift
//  TeamUP
//
//  Created by 강희창 on 11/16/24.
//

import SwiftUI
import Alamofire
import KeychainSwift

final class AuthManager: ObservableObject {
    private let keychain = KeychainSwift()
    
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
    
    // MARK: - 서버 로그인 요청
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let loginEndpoint = "https://protectmeios.xyz/user/signin"
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        AF.request(loginEndpoint, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: Token.self) { response in
                switch response.result {
                case .success(let token):
                    self.saveToken(token) // 성공 시 JWT 저장
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error)) // 실패 시 에러 반환
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
}

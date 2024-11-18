//
//  SignUPViewModel.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

final class SignUPViewModel: ObservableObject {
    @Published private(set) var user: User? = nil
    @Published var emailState = ValidationState()
    @Published var canProceedToNextStep: Bool = false // "다음" 버튼 활성화 상태
    @Published var nicknameState = ValidationState()
    @Published var passwordState = ValidationState()
    
    private var defaultURL: URLComponents = URLComponents()
    
    init() {
        if let urlString = Bundle.main.infoDictionary?["UrlString"],
           let urlS = urlString as? String {
            defaultURL.scheme = "https"
            defaultURL.host = urlS
        }
    }
    
    struct ValidationState {
        var value: String = ""
        var isValid: Bool = false   //형식 유효
        var isChecked: Bool = false //중복 여부
        var message: String? = nil  //에러 혹은 성공 메시지
        var color: Color = .red
    }
    
    // MARK: - 이메일 중복
    func checkEmail() async {
        var url = defaultURL
        url.path = "/check-exist/emnail/data"
        url.queryItems = [URLQueryItem(name: "email", value: emailState.value)]
        
        guard let requestURL = url.url else {
            return
        }
        
        do {
            AF.request(requestURL, method: .get).responseDecodable(of: [String:Bool].self) { response in
                switch response.result {
                case .success(let data):
                    if let isDuplicated = data["exist"], isDuplicated {
                        self.emailState.isChecked = false
                        self.emailState.message = "중복된 이메일입니다."
                        self.emailState.color = .red
                    } else {
                        self.emailState.isChecked = true
                        self.emailState.message = "사용 가능한 이메일입니다."
                        self.emailState.color = .blue
                    }
                    self.updateProceedState()
                case .failure(let error):
                    print("Email check error: \(error.localizedDescription)" )
                }
            }
        }
    }
    // MARK: - 닉네임 중복
    func checkNicknameAvilablity(nickname: String) async {
        var url = defaultURL
        url.path = "/check-exists/nickname/data"
        url.queryItems = [URLQueryItem(name: "nickname", value: nickname)]
        
        guard let requestURL = url.url else {
            return
        }
        
        do {
            AF.request(requestURL, method: .get).responseDecodable(of: [String:Bool].self) { response in
                switch response.result {
                case .success(let data):
                    if let data = data["exist"] {
                        self.nicknameState.isValid = data
                    }
                case .failure(let error):
                    print("Nickname check error: \(error.localizedDescription)")
                }
            }
        }
    }
    // MARK: - 회원가입
    func signUp(user: User, password: String) async throws {
        defaultURL.path = "/user/signup"
        guard let url = defaultURL.url else {
            return
        }
        
        let parameters: [String: Any] = [
            "id": user.id,
            "email": user.email,
            "password": user.password,
            "nickname": user.nickname,
            "profile_image_name": user.profileImageName
        ]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // 유효성 검사 로직을 재사용 가능한 함수로 분리
    func validateField(_ value: String, regex: String, for state: inout ValidationState) {
        let isValid = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: value)
        if isValid {
            state.isValid = true
            state.message = nil
        } else {
            state.isValid = false
            state.message = "형식이 올바르지 않습니다."
            state.color = .red
        }
    }
    
    // 이메일 유효성 검사
    func validateEmailFormat() {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        if NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: emailState.value) {
            emailState.isValid = true
            emailState.message = nil
        } else {
            emailState.isValid = false
            emailState.message = "이메일 형식이 아닙니다."
            emailState.color = .red
        }
        emailState.isChecked = false // 형식이 변경되면 중복 상태 초기화
        updateProceedState()
    }
    
    // 닉네임 유효성 검사
    func validateNickname(_ nickname: String) {
        let nicknameRegex = "^[a-zA-Z0-9_-]{3,15}$"
        validateField(nickname, regex: nicknameRegex, for: &nicknameState)
    }
    
    // 비밀번호 유효성 검사
    func validatePassword(_ password: String) {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        validateField(password, regex: passwordRegex, for: &passwordState)
    }
    
    // 중복 검사 로직 재사용
    func checkDuplication(for field: String, with value: String, state: inout ValidationState, path: String) {
        var url = defaultURL
        url.path = path
        url.queryItems = [URLQueryItem(name: field, value: value)]
        
        guard let requestURL = url.url else {
            return 
        }
    }
    // "다음" 버튼 활성화 상태 업데이트
    private func updateProceedState() {
        canProceedToNextStep = emailState.isValid && emailState.isChecked
    }
}

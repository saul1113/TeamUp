//
//  LoginView.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI
import Alamofire

struct LoginView: View {
    @EnvironmentObject var authManager: AuthManager // AuthManager 사용
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isLoading: Bool = false // 로딩 상태
    @State private var loginErrorMessage: String? = nil // 에러 메시지
    @State private var navigateToMain: Bool = false // 메인 화면 이동 여부
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer()
                
                // 이메일 입력
                VStack(alignment: .leading) {
                    Text("이메일")
                        .font(.semibold18)
                    
                    TextField("이메일을 입력해주세요", text: $email)
                        .padding(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.customLightGray, lineWidth: 1)
                        )
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                }
                
                Spacer()
                    .frame(height: 40)
                
                // 비밀번호 입력
                VStack(alignment: .leading) {
                    Text("비밀번호")
                        .font(.semibold18)
                    
                    HStack {
                        if isPasswordVisible {
                            TextField("비밀번호를 입력해주세요", text: $password)
                        } else {
                            SecureField("비밀번호를 입력해주세요", text: $password)
                        }
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                .foregroundColor(.customLightGray)
                        }
                    }
                    .padding(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.customLightGray, lineWidth: 1)
                    )
                }
                
                Spacer()
                    .frame(height: 40)
                
                // 에러 메시지
                if let loginErrorMessage = loginErrorMessage {
                    Text(loginErrorMessage)
                        .foregroundColor(.customRed)
                        .font(.regular14)
                        .padding(.bottom, 10)
                }
                
                // 로그인 버튼
                Button(action: login) {
                    if isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 48)
                    } else {
                        Text("로그인")
                            .font(.semibold20)
                            .foregroundColor(isLoginEnabled ? .white : .customDarkGray)
                            .frame(maxWidth: .infinity, minHeight: 48)
                            .background(isLoginEnabled ? Color.customBlue : Color.customLightGray)
                            .cornerRadius(4)
                    }
                }
                .disabled(!isLoginEnabled || isLoading)
                
                // 회원가입 링크
                HStack {
                    Spacer()
                    
                    Text("계정이 없으신가요?")
                        .font(.regular16)
                        .foregroundColor(.customDarkGray)
                    
                    NavigationLink(destination: SignUPView(email: $email)) {
                        Text("가입하기")
                            .font(.regular16)
                            .foregroundColor(.customBlue)
                    }
                }
                .padding(.vertical)
                
                Spacer()
                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .backButton()
            .navigationDestination(isPresented: $navigateToMain) {
                MainTabView() // 로그인 성공 시 이동
            }
            .onAppear {
                UITextField.appearance().clearButtonMode = .whileEditing
            }
        }
    }
    
    private var isLoginEnabled: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    // MARK: - 로그인 함수
    private func login() {
        guard isLoginEnabled else { return }
        isLoading = true
        loginErrorMessage = nil
        
        authManager.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success:
                    navigateToMain = true
                case .failure(let error):
                    if let afError = error as? AFError, let responseCode = afError.responseCode {
                        switch responseCode {
                        case 401:
                            loginErrorMessage = "이메일 또는 비밀번호가 잘못되었습니다."
                        case 500:
                            loginErrorMessage = "서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요."
                        default:
                            loginErrorMessage = "알 수 없는 오류가 발생했습니다."
                        }
                    } else {
                        loginErrorMessage = "네트워크 연결을 확인해주세요."
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}

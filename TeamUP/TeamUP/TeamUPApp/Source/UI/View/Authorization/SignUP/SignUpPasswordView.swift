//
//  SignUpPasswordView.swift
//  TeamUP
//
//  Created by 강희창 on 11/18/24.
//

import SwiftUI

struct SignUpPasswordView: View {
    @State private var progress = 0.7
    @State private var password: String = ""
    @State private var confirmPassword: String = ""    // 비밀번호 확인 입력
    @State private var isPasswordMatched: Bool = true  // 비밀번호 일치 여부
    @State private var canProceedToNextStep: Bool = false // 다음 버튼 활성화 상태
    @State private var errorMessage: String? = nil
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                ScrollView {
                    Spacer()
                        .frame(height: 10)
                    ProgressView(value: progress)
                    
                    
                    Spacer()
                        .frame(height: 40)
                    VStack(alignment: .leading) {
                        Text("비밀번호를 입력해주세요")
                            .font(Font.bold24)
                        Text("로그인 시 사용할 비밀번호를 입력해주세요.")
                            .font(Font.regular14)
                            .foregroundStyle(.gray)
                    }
                    .padding(.leading, -130)
                    
                    Spacer()
                        .frame(height: 50)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("비밀번호")
                            .font(.semibold16)
                        TextFieldView(
                            text: $password,
                            placeholder: "비밀번호 설정",
                            isSecure: true
                        )
                    }
                    Spacer()
                        .frame(height: 40)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("비밀번호 확인")
                            .font(.semibold16)
                        TextFieldView(
                            text: $confirmPassword,
                            placeholder: "비밀번호와 동일하게 설정해주세요.",
                            isSecure: true,
                            errorColor: .red,
                            errorMessage: errorMessage
                        )
                        .onChange(of: confirmPassword) { _ in validatePasswords()
                        }
                    }
                }
                Spacer()
                NavigationLink(
                    destination: SignUpNicknameView(),
                    isActive: $canProceedToNextStep // 조건 만족 시 활성화
                ) {
                    Text("다 음")
                        .frame(width: 360, height: 50)
                        .font(.headline)
                        .foregroundColor(.white)
                        .background(canProceedToNextStep ? Color.customBlue : Color.gray)
                        .cornerRadius(4)
                }
                .disabled(canProceedToNextStep)
                
                Spacer()
                    .frame(height: 90)
            }
            .padding(.horizontal, 20)
            .navigationTitle("회원가입")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton()
                }
            }
        }
    }
    // MARK: - 비밀번호 유효성 검사
    private func validatePasswords() {
        // 비밀번호와 확인 비밀번호가 일치하는지 검사
        if password.isEmpty || confirmPassword.isEmpty {
            errorMessage = nil // 비어있는 경우 에러 메시지 없음
            isPasswordMatched = false
        } else if password != confirmPassword {
            errorMessage = "비밀번호가 일치하지 않습니다."
            isPasswordMatched = false
        } else {
            errorMessage = nil
            isPasswordMatched = false
        }
        updateProceedState()
    }
    
    // MARK: - 진행 상태 업데이트
    private func updateProceedState() {
        canProceedToNextStep = isPasswordMatched && !password.isEmpty && !confirmPassword.isEmpty
    }
}

#Preview {
    SignUpPasswordView()
        .environmentObject(AuthManager())
}

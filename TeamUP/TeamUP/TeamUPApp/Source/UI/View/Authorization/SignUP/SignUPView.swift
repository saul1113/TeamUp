//
//  SignUPView.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI

struct SignUPView: View {
    @Environment(AuthManager.self) var authManager: AuthManager // AuthManager 인스턴스 사용
    
    @State private var progress = 0.0
    @State private var email: String = ""
    @State private var isEmailValid: Bool = false    // 이메일 형식 유효성
    @State private var isEmailChecked: Bool = false  // 이메일 중복 확인 여부
    @State private var emailMessage: String? = nil   // 이메일 관련 메시지
    @State private var emailMessageColor: Color = .red
    @State private var canProceedToNextStep: Bool = false // 다음 버튼 활성화 상태
    @State private var isNavigatingToPasswordView: Bool = false // NavigationLink 제어 상태
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                    .frame(height: 10)
                ProgressView(value: progress)
                    .animation(.easeInOut(duration: 1), value: progress) // 애니메이션 추가
                
                Spacer()
                    .frame(height: 40)
                VStack(alignment: .leading, spacing: 10) {
                    Text("이메일을 입력해주세요")
                        .font(.bold24)
                    Text("로그인 시 사용할 이메일을 형식에 맞게 입력해주세요")
                        .font(.regular14)
                        .foregroundStyle(.gray)
                }
                ScrollView {
                    
                    Spacer()
                        .frame(height: 60)
                    HStack(spacing: 10) {
                        TextFieldView(
                            text: $email,
                            placeholder: "email@example.com",
                            isSecure: false,
                            errorColor: emailMessageColor,
                            errorMessage: emailMessage
                        ) { newValue in
                            validateEmail()
                        }
                        .onChange(of: email) { _ in
                            validateEmail()
                        }
                        .padding(.top, 25)
                        
                        Button(action: {
                            Task {
                                await checkEmail()
                            }
                        }) {
                            Text("중복확인")
                                .font(.semibold16)
                                .padding()
                                .frame(height: 42)
                                .background(isEmailValid ? Color.customBlue : Color.customLightGray)
                                .foregroundColor(isEmailValid ? .white : .customDarkGray)
                                .cornerRadius(4)
                        }
                        .disabled(!isEmailValid) // 이메일 형식이 맞아야 버튼 활성화
                    }
                }
                Spacer()
                
                NavigationLink(
                    destination: SignUpPasswordView(email: $email),
                    isActive: $isNavigatingToPasswordView
                ) {
                    EmptyView() // NavigationLink 트리거 역할
                }
                
                Button(action: {
                    // 다음 화면으로 이동 로직
                    if canProceedToNextStep {
                        isNavigatingToPasswordView = true
                    }
                }) {
                    Text("다 음")
                        .frame(width: 360, height: 50)
                        .font(.semibold20)
                        .foregroundColor(canProceedToNextStep ? .white : .customDarkGray)
                        .background(canProceedToNextStep ? Color.customBlue : Color.customLightGray)
                        .cornerRadius(4)
                }
                .disabled(!canProceedToNextStep)
                
                Spacer().frame(height: 35)
            }
            .padding(.horizontal, 20)
            .navigationTitle("회원가입")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButtonBlack()
                }
            }
        }
        .onAppear {
            startProgressAnimation() // 뷰가 나타날 때 진행률 애니메이션 시작
        }
    }
    private func startProgressAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation {
                self.progress = 0.3 // 애니메이션과 함께 30%로 증가
            }
        }
    }
    
    // MARK: - 이메일 유효성 검사
    private func validateEmail() {
        let emailPattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        isEmailValid = emailPredicate.evaluate(with: email)
        
        if isEmailValid {
            emailMessage = nil
            emailMessageColor = .blue
        } else {
            emailMessage = "이메일 형식이 아닙니다"
            emailMessageColor = .red
        }
        isEmailChecked = false
        updateProceedState()
    }
    // MARK: - 이메일 중복 확인
    private func checkEmail() async {
        guard isEmailValid else { return } // 유효하지 않으면 요청하지 않음
        
        do {
            let isDuplicated = try await authManager.checkEmailAvailability(email: email)
            DispatchQueue.main.async {
                if isDuplicated {
                    self.isEmailChecked = false
                    self.emailMessage = "중복된 이메일입니다"
                    self.emailMessageColor = .red
                } else {
                    self.isEmailChecked = true
                    self.emailMessage = "사용 가능한 이메일입니다"
                    self.emailMessageColor = .blue
                }
                updateProceedState()
            }
        } catch {
            DispatchQueue.main.async {
                print("Email check error: \(error.localizedDescription)")
                let nsError = error as NSError
                if nsError.domain == NSURLErrorDomain {
                    self.emailMessage = "네트워크 연결에 문제가 있습니다. 다시 시도해주세요"
                } else {
                    self.emailMessage = "서버 오류가 발생했습니다. 다시 시도해주세요"
                }
                self.emailMessageColor = .red
            }
        }
    }
    // MARK: - 진행 상태 업데이트
    private func updateProceedState() {
        canProceedToNextStep = isEmailValid && isEmailChecked
    }
}

#Preview {
    SignUPView()
        .environment(AuthManager())
}

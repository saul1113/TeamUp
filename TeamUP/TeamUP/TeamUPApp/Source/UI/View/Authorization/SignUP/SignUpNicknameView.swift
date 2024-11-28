//
//  SignUpNicknameView.swift
//  TeamUP
//
//  Created by 강희창 on 11/18/24.
//

import SwiftUI

struct SignUpNicknameView: View {
    @Binding var email: String // 상위 뷰에서 전달받는 이메일
    @Binding var password: String // 상위 뷰에서 전달받는 비밀번호
    @State private var progress = 0.7
    @State private var nickname: String = ""
    @State private var isNicknameValid: Bool = false // 닉네임 유효성 검사 상태
    @State private var isNicknameChecked: Bool = false // 닉네임 중복 확인 여부
    @State private var errorMessage: String? = nil   // 에러 메시지
    @State private var canProceedToNextStep: Bool = false
    @State private var errorColor: Color = .red
    @State private var showCompletionMessage: Bool = false // 완료 메시지 표시 상태
    
    @Environment(AuthManager.self) private var authManager: AuthManager
    @State private var navigateToLoginView = false // 로그인 화면으로 이동 상태
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                        .frame(height: 10)
                    ProgressView(value: progress)
                        .animation(.easeInOut(duration: 1), value: progress)
                    
                    
                    Spacer()
                        .frame(height: 40)
                    VStack(alignment: .leading) {
                        Text("닉네임을 입력해주세요")
                            .font(.bold24)
                        Text("닉네임은 2자부터 6자까지 설정해주세요")
                            .font(.regular14)
                            .foregroundStyle(.gray)
                    }
                    
                    ScrollView {
                        Spacer()
                            .frame(height: 50)
                        VStack(alignment: .leading, spacing: -15) {
                            Text("닉네임")
                                .font(.semibold16)
                            HStack {
                                TextFieldView(
                                    text: $nickname,
                                    placeholder: "2 - 6자까지 입력",
                                    isSecure: false,
                                    errorColor: errorColor,
                                    errorMessage: errorMessage
                                )
                                .onChange(of: nickname) { _ in
                                    validateNickname() // 닉네임 변경 시 유효성 검사
                                    resetStateOnChange() //중복확인 초기화
                                }
                                .padding(.top, 25)
                                
                                Button(action: {
                                    Task {
                                        await checkNickname()
                                    }
                                }) {
                                    Text("중복확인")
                                        .font(.semibold16)
                                        .padding()
                                        .frame(height: 42)
                                        .background(isNicknameValid ? Color.customBlue : Color.customLightGray)
                                        .foregroundColor(isNicknameValid ? .white : .customDarkGray)
                                        .cornerRadius(4)
                                }
                                .disabled(!isNicknameValid)
                            }
                        }
                        .padding(.horizontal, 1)
                    }
                    Spacer()
                    NavigationLink(
                        destination: LoginView().navigationBarBackButtonHidden(true),
                        isActive: $navigateToLoginView // 상태와 연결
                    ) {
                        EmptyView() // NavigationLink 표시 안 함
                    }
                    Button(action: {
                        Task {
                            await handleSignUp()
                        }
                    }) {
                        Text("회 원 가 입")
                            .frame(width: 360, height: 50)
                            .font(.semibold20)
                            .foregroundColor(.white)
                            .background(canProceedToNextStep ? Color.customBlue : Color.gray)
                            .cornerRadius(4)
                    }
                    .disabled(!canProceedToNextStep)
                    
                    Spacer()
                        .frame(height: 90)
                }
                .padding(.horizontal, 20)
                .navigationTitle("회원가입")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .onAppear {
                    startProgressAnimation()
                }
                
                if showCompletionMessage {
                    Text("회원가입이 완료되었습니다")
                        .font(.semibold16)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.customBlue)
                        .cornerRadius(10)
                        .transition(.opacity) // 애니메이션 효과
                        .zIndex(1) // 메시지가 다른 뷰 위에 표시되도록 설정
                }
            }
        }
    }
    
    // MARK: - 진행률 애니메이션
    private func startProgressAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation {
                self.progress = 0.99 // 애니메이션과 함께 30%로 증가
            }
        }
    }
    
    // MARK: - 닉네임 유효성 검사
    private func validateNickname() {
        // 닉네임 길이 검사
        if nickname.count >= 2 && nickname.count <= 6 {
            errorMessage = nil
            isNicknameValid = true
        } else {
            errorMessage = "닉네임은 2자에서 6자까지 입력해주세요"
            isNicknameValid = false
        }
        updateProceedState()
    }
    
    // MARK: - 닉네임 중복 확인
    private func checkNickname() async {
        guard isNicknameValid else { return }
        
        do {
            let isDuplicated = try await authManager.checkNicknameAvailability(nickname: nickname)
            DispatchQueue.main.async {
                if isDuplicated {
                    self.isNicknameChecked = false
                    self.errorMessage = "중복된 닉네임입니다"
                    self.errorColor = .red
                } else {
                    self.isNicknameChecked = true
                    self.errorMessage = "사용 가능한 닉네임입니다"
                    self.errorColor = .blue
                }
                updateProceedState()
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "네트워크 오류가 발생했습니다. 다시 시도해주세요"
                self.errorColor = .red
            }
        }
    }
    
    // MARK: - 회원가입 처리
    private func handleSignUp() async {
        let user = User(
            id: "",
            email: email,
            password: password,
            nickname: nickname,
            profileImageName: "default.png"
        )
        do {
            try await authManager.signUp(user: user, password: password)
            DispatchQueue.main.async {
                withAnimation {
                    showCompletionMessage = true // 완료 메시지 표시
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2초 후 메시지 숨김
                    withAnimation {
                        showCompletionMessage = false
                        navigateToLoginView = true // 로그인 화면으로 이동
                    }
                }
            }
        } catch {
            DispatchQueue.main.async {
                errorMessage = "회원가입 중 오류가 발생했습니다. 다시 시도해주세요"
                errorColor = .red
            }
        }
    }
    // MARK: - 진행 상태 업데이트
    private func updateProceedState() {
        canProceedToNextStep = isNicknameChecked && isNicknameValid
    }
    
    // MARK: - 닉네임 변경 시 상태 초기화
    private func resetStateOnChange() {
        isNicknameChecked = false // 닉네임이 변경되면 중복 확인 상태 초기화
        errorMessage = nil
        errorColor = .red
        updateProceedState() // 버튼 비활성화
    }
}

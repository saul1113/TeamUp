//
//  SignUpNicknameView.swift
//  TeamUP
//
//  Created by 강희창 on 11/18/24.
//

import SwiftUI

struct SignUpNicknameView: View {
    @State private var progress = 0.99
    @State private var nickname: String = ""
    @State private var isNicknameValid: Bool = false // 닉네임 유효성 검사 상태
    @State private var errorMessage: String? = nil   // 에러 메시지
    @State private var canProceedToNextStep: Bool = false
    @State private var errorColor: Color = .red
    
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                    .frame(height: 10)
                ProgressView(value: progress)
                
                Spacer()
                    .frame(height: 40)
                VStack(alignment: .leading) {
                    Text("닉네임을 입력해주세요.")
                        .font(.bold24)
                    Text("닉네임은 2자부터 6자까지 설정해주세요.")
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
                            TextFieldView(text: $nickname, placeholder: "2 - 6자까지 입력", isSecure: false,
                                          errorColor: errorColor,
                                          errorMessage: errorMessage
                            )
                            .onChange(of: nickname) { _ in
                                validateNickname() // 닉네임 변경 시 유효성 검사
                            }
                            .padding(.top, 25)
                            
                            Button(action: {
                                Task {
                                    await checkNickname()
                                }
                            }) {
                                Text("중복 확인")
                                    .padding()
                                    .font(.semibold14)
                                    .frame(height: 45)
                                    .background(isNicknameValid ? Color.customBlue : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(4)
                            }
                            .disabled(!isNicknameValid)
                        }
                    }
                    .padding(.horizontal, 1)
                }
                Spacer()
                
                NavigationLink(destination: LoginView()) {
                    Text("회 원 가 입")
                        .frame(width: 360, height: 50)
                        .font(.semibold20)
                        .foregroundColor(.white)
                        .background(Color.customBlue)
                        .cornerRadius(4)
                }
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
    // MARK: - 닉네임 유효성 검사
    private func validateNickname() {
        // 닉네임 길이 검사
        if nickname.count >= 2 && nickname.count <= 6 {
            errorMessage = nil
            isNicknameValid = true
        } else {
            errorMessage = "닉네임은 2자에서 6자까지 입력해주세요."
            isNicknameValid = false
        }
    }
    
    // MARK: - 닉네임 중복 확인
    private func checkNickname() async {
        guard isNicknameValid else { return } // 유효하지 않으면 요청하지 않음
        
        do {
            let isDuplicated = try await authManager.checkNicknameAvailability(nickname: nickname)
            DispatchQueue.main.async {
                if isDuplicated {
                    self.isNicknameValid = false
                    self.errorMessage = "중복된 닉네임입니다."
                    self.errorColor = .red
                } else {
                    self.isNicknameValid = true
                    self.errorMessage = "사용 가능한 닉네임입니다."
                    self.errorColor = .blue
                }
            }
        } catch {
            DispatchQueue.main.async {
                print("Nickname check error: \(error.localizedDescription)")
                let nsError = error as NSError
                if nsError.domain == NSURLErrorDomain {
                    self.errorMessage = "네트워크 연결에 문제가 있습니다. 다시 시도해주세요."
                } else {
                    self.errorMessage = "서버 오류가 발생했습니다. 다시 시도해주세요."
                }
                self.errorColor = .red
            }
        }
    }
}

#Preview {
    SignUpNicknameView()
}

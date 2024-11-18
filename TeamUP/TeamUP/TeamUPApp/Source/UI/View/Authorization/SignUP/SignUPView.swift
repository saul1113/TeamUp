//
//  SignUPView.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI

struct SignUPView: View {
    @State private var progress = 0.3
    @StateObject private var viewModel = SignUPViewModel()
    @Binding var email: String
    
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
                        Text("이메일을 입력해주세요.")
                            .font(Font.bold24)
                        Text("로그인 시 사용할 이메일을 형식에 맞게 입력해주세요.")
                            .font(Font.regular14)
                    }
                    .padding(.leading, -70)
                    
                    Spacer()
                        .frame(height: 60)
                    HStack(spacing: 10) {
                        TextFieldView(text: $viewModel.emailState.value, placeholder: "email@example.com", isSecure: false, errorColor: viewModel.emailState.color, errorMessage: viewModel.emailState.message) { newValut in
                            viewModel.validateEmailFormat()
                        }
                        
                        Button(action: {
                            Task {
                                await viewModel.checkEmail()
                            }
                        }) {
                            Text("중복 확인")
                                .padding()
                                .frame(height: 45)
                                .background(viewModel.emailState.isValid ? Color.customBlue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(4)
                        }
                    }
                    .disabled(!viewModel.emailState.isValid)
                    
                    Spacer()
                }
                NavigationLink(destination: SignUpPasswordView(), isActive: $viewModel.canProceedToNextStep) {
                    Text("다 음")
                        .frame(width: 360, height: 50)
                        .font(.semibold20)
                        .foregroundStyle(.white)
                        .background(viewModel.canProceedToNextStep ? Color.customBlue : Color.gray)
                    
                    Spacer()
                        .frame(height: 90)
                }
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
}

#Preview {
    SignUPView(email: .constant(""))
}

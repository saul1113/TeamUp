//
//  LoginView.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            VStack(alignment: .leading) {
                Text("이메일")
                    .font(.semibold18)
                
                TextField("이메일을 입력해주세요", text: $email)
                    .padding(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
            }
            
            Spacer()
                .frame(height: 40)
            
            VStack(alignment: .leading, spacing: 8) {
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
                            .foregroundColor(.gray)
                    }
                }
                .padding(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            }
            
            Spacer()
                .frame(height: 40)
            
            NavigationLink(
                destination: MainTabView(),
                label: {
                    Text("로그인")
                        .font(.headline)
                        .foregroundColor(isLoginEnabled ? .white : .gray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(isLoginEnabled ? Color.blue : Color.gray.opacity(0.4))
                        .cornerRadius(4)
                }
            )
            .disabled(!isLoginEnabled)
            
            // Sign Up Link
            HStack {
                Spacer()
                
                Text("계정이 없으신가요?")
                    .font(.regular12)
                    .foregroundColor(.gray)
                Button(action: {
                   
                }) {
                    Text("가입하기")
                        .font(.regular12)
                        .foregroundColor(.blue)
                }
            }
            
            Spacer()
        }
        .padding()
    }
    
    private var isLoginEnabled: Bool {
        !email.isEmpty && !password.isEmpty
    }
}

//#Preview {
//    LoginView()
//}

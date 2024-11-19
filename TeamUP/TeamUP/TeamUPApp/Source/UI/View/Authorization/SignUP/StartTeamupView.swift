//
//  StartTeamupView.swift
//  TeamUP
//
//  Created by 강희창 on 11/16/24.
//

import SwiftUI

struct StartTeamupView: View {
    @StateObject private var authManager = AuthManager()
    @State private var email: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                if authManager.isAuthenticated {
                    // 로그인 상태라면 MainTabView로 이동
                    MainTabView()
                        .environmentObject(authManager) // MainTabView에 AuthManager 전달
                } else {
                    // 로그인되지 않은 경우 로그인/회원가입 화면 표시
                    Color.customBlue.ignoresSafeArea()
                    loginOrSignUpView
                        .environmentObject(authManager) // LoginView, SignUpView에서 AuthManager 사용
                }
            }
            .onAppear {
                // 앱 실행 시 자동 로그인 확인
                if authManager.hasAccessToken() {
                    print("자동 로그인 상태: \(authManager.getToken(key: "access_token") ?? "")")
                    authManager.isAuthenticated = true
                } else {
                    print("로그인이 필요합니다.")
                    authManager.isAuthenticated = false
                }
            }
        }
    }
    
    // 로그인 및 회원가입 UI
    private var loginOrSignUpView: some View {
        VStack(alignment: .center, spacing: 0) {
            Image(systemName: "person.fill")
            
            Spacer()
                .frame(height: 400)
            
            NavigationLink(destination: LoginView()) {
                HStack {
                    Image(systemName: "envelope.fill")
                    Text("이메일로 로그인")
                        .font(Font.semibold14)
                }
                .padding(.horizontal, 88)
                .padding(.vertical, 11)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.white, lineWidth: 1))
            }
            
            Spacer()
                .frame(height: 23)
            
            NavigationLink(destination: SignUPView(email: $email)) {
                Text("회원가입")
                    .font(Font.semibold14)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    StartTeamupView()
}

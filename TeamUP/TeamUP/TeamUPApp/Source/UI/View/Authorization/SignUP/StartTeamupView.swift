//
//  StartTeamupView.swift
//  TeamUP
//
//  Created by 강희창 on 11/16/24.
//

import SwiftUI

struct StartTeamupView: View {
    @State private var email: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color.customBlue.ignoresSafeArea()
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
                        .font(Font.semibold14)
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
    }
}

#Preview {
    StartTeamupView()
}

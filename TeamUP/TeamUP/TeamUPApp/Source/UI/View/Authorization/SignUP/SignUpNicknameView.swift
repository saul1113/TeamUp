//
//  SignUpNicknameView.swift
//  TeamUP
//
//  Created by 강희창 on 11/18/24.
//

import SwiftUI

struct SignUpNicknameView: View {
    @State private var progress = 0.95
    @State private var nickname: String = ""
    @State private var errorMessage: String? = nil
    
    
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
                        Text("닉네임을 입력해주세요.")
                            .font(Font.bold24)
                        Text("닉네임은 2자부터 6자까지 설정해주세요.")
                            .font(Font.regular14)
                            .foregroundStyle(.gray)
                    }
                    .padding(.leading, -140)
                    
                    Spacer()
                        .frame(height: 50)
                    VStack(alignment: .leading, spacing: -15) {
                        Text("닉네임")
                            .font(.semibold16)
                        HStack {
                            TextFieldView(text: $nickname, placeholder: "2 - 6자까지 입력", isSecure: false,
                                          errorColor: .red,
                                          errorMessage: errorMessage
                            )
                            .padding(.top, 25)
                            
                            Button(action: {
                                Task {
                                    
                                }
                            }) {
                                Text("중복 확인")
                                    .padding()
                                    .frame(height: 45)
                                    .background(Color.customBlue)
                                    .foregroundColor(.white)
                                    .cornerRadius(4)
                            }
                        }
                    }
                }
                Spacer()
                
                NavigationLink(destination: HomeView()) {
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
}

#Preview {
    SignUpNicknameView()
}

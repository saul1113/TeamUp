//
//  TeamDetailView.swift
//  TeamUP
//
//  Created by Hwang_Inyoung on 11/21/24.
//

import SwiftUI

struct TeamDetailView: View {
    let team: Post
    @State private var applicants: [User] = [
        User(id: "1", email: "applicant1@test.com", password: "123", nickname: "지원자1", profileImageName: "default.png"),
        User(id: "2", email: "applicant2@test.com", password: "123", nickname: "지원자2", profileImageName: "default.png")
    ]
    @State private var applicationStatus: [String] = ["신청대기", "신청대기"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(team.title)
                    .font(.bold24)
                    .padding(.bottom, 5)
                
                Text("작성일: \(team.time)")
                    .font(.regular14)
                    .foregroundColor(.gray)
                
                Divider()
                
                Text(team.content)
                    .font(.regular16)
                    .padding(.bottom, 10)
                
                Divider()
                
                Text("신청한 사람 \(applicants.count)")
                    .font(.semibold16)
                
                ForEach(applicants.indices, id: \.self) { index in
                    HStack {
                        Circle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Text(applicants[index].nickname.prefix(1))
                                    .font(.bold16)
                                    .foregroundColor(.white)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(applicants[index].nickname)
                                .font(.bold16)
                            Text("1시간 전")
                                .font(.regular12)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        
                        Menu {
                            Button("수락", action: { applicationStatus[index] = "수락됨" })
                            Button("거절", action: { applicationStatus[index] = "거절됨" })
                        } label: {
                            Text(applicationStatus[index])
                                .font(.regular14)
                                .foregroundColor(.customBlue)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(4)
                        }
                    }
                    Divider()
                }
                
                Button(action: {
                    // 모집 완료 로직
                }) {
                    Text("모집 완료하기")
                        .font(.semibold20)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.customBlue)
                        .cornerRadius(4)
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonBlack()
            }
        }
    }
}

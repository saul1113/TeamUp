//
//  MyRecruitingTeamsView.swift
//  TeamUP
//
//  Created by Hwang_Inyoung on 11/21/24.
//

import SwiftUI

struct MyRecruitingTeamsView: View {
    let recruitingTeams: [Post] = [
        Post(
            id: 1, category: .study,
            user: User(id: "1", email: "test@test.com", password: "123", nickname: "수민", profileImageName: "default.png"),
            isRecruit: true,
            title: "알고리즘 스터디",
            content: "초보 환영하고 간혹 친목도 해요 연락주세요!",
            time: "2024년 11월 18일",
            save: 1,
            seen: 10,
            maxCapacity: 10,
            currentCapacity: 5,
            hasTag: ["알고리즘"]
        ),
        Post(
            id: 2, category: .project,
            user: User(id: "2", email: "test2@test.com", password: "123", nickname: "원호", profileImageName: "default.png"),
            isRecruit: true,
            title: "웹 프로젝트",
            content: "진행 중인 웹 프로젝트에 함께할 팀원을 구합니다.",
            time: "2024년 11월 18일",
            save: 1,
            seen: 10,
            maxCapacity: 8,
            currentCapacity: 3,
            hasTag: ["프로젝트"]
        )
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(spacing: 15) { // 카드 사이의 간격을 위해 VStack 사용
                        ForEach(recruitingTeams, id: \.id) { team in
                            NavigationLink(destination: TeamDetailView(team: team)) {
                                ListRowView(model: team, isMyPage: false)
                            }
                            
                            Divider()
                        }
                    }
                    .padding(.horizontal, 20) // 전체 ScrollView의 좌우 패딩
                    .padding(.top, 15) // ScrollView 상단 여백
                }
                .padding(.bottom, 50)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButtonBlack()
                }
                
                ToolbarItem(placement: .principal) {
                    Text("내가 모집중인 팀")
                        .font(.semibold18)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

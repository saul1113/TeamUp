//
//  MyBookmarksView.swift
//  TeamUP
//
//  Created by 김수민 on 11/22/24.
//

import SwiftUI

struct MyBookmarksView: View {
    @State private var selectedTab = 0
    @State private var searchText = ""
    
    // 홈 더미 데이터
    @State private var homePosts: [Post] = [
        Post(
            id: 2, category: .study,
            user: User(id: "1", email: "test@test.com", password: "123", nickname: "ios유령", profileImageName: "default.png"),
            isRecruit: true,
            title: "AI 기반 웹 서비스 개발",
            content: "AI 알고리즘을 활용한 웹 서비스를 개발할 팀원을 모집합니다. Python과 Django를 사용하며, 데이터 분석 및 모델링 경험이 있는 분을 선호합니다.",
            time: "2024-11-25 13:42",
            save: 2,
            seen: 13,
            maxCapacity: 15,
            currentCapacity: 2,
            hasTag: ["알고리즘"]
        ),
        Post(
            id: 4, category: .project,
            user: User(id: "2", email: "test2@test.com", password: "123", nickname: "튜나랜드", profileImageName: "default.png"),
            isRecruit: false,
            title: "웹 프로젝트",
            content: "진행 중인 웹 프로젝트에 함께할 팀원을 구합니다.",
            time: "1시간 전",
            save: 5,
            seen: 20,
            maxCapacity: 8,
            currentCapacity: 3,
            hasTag: ["프로젝트"]
        )
    ]
    
    // 라운지 더미 데이터
    @State private var loungePosts: [Rounge] = [
        Rounge(
            id: 3, category: .qna,
            user: User(id: "3", email: "test3@test.com", password: "123", nickname: "Asdf", profileImageName: "default.png"),
            title: "질문 있습니다!",
            content: "프로젝트 마감 일정은 어떻게 조율하시나요?",
            reply: [],
            time: "2시간 전",
            save: 10,
            seen: 8,
            hasTag: ["질문"]
        ),
        Rounge(
            id: 4, category: .qna,
            user: User(id: "4", email: "test4@test.com", password: "123", nickname: "lucy", profileImageName: "default.png"),
            title: "질문 있습니다!",
            content: "다들 지치고 힘들 때 어떻게 하나요?",
            reply: [],
            time: "5시간 전",
            save: 10,
            seen: 8,
            hasTag: ["질문"]
        )
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .bottom, spacing: 0) {
                    Button(action: {
                        selectedTab = 0
                    }) {
                        VStack(spacing: 5) {
                            Text("홈")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(selectedTab == 0 ? .black : .gray)
                            Rectangle()
                                .fill(selectedTab == 0 ? Color.customBlue : Color.gray)
                                .frame(height: selectedTab == 0 ? 3 : 0.4)
                        }
                    }
                    
                    Button(action: {
                        selectedTab = 1
                    }) {
                        VStack(spacing: 5) {
                            Text("라운지")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(selectedTab == 1 ? .black : .gray)
                            Rectangle()
                                .fill(selectedTab == 1 ? Color.customBlue : Color.gray)
                                .frame(height: selectedTab == 1 ? 3 : 0.4)
                        }
                    }
                }
                .font(.semibold20)
                .padding(.horizontal, 20)
                
                ScrollView {
                    if selectedTab == 0 {
                        // 홈 탭
                        ForEach(homePosts.filter { post in
                            searchText.isEmpty || post.title.contains(searchText)
                        }, id: \.id) { post in
                            NavigationLink(destination: HomeLoungeDetailView(model: post)) {
                                ListRowView(model: post, isMyPage: true)
                            }
                            Divider()
                        }
                    } else {
                        // 라운지 탭
                        ForEach(loungePosts.filter { post in
                            searchText.isEmpty || post.title.contains(searchText)
                        }, id: \.id) { post in
                            NavigationLink(destination: HomeLoungeDetailView(model: post)) {
                                ListRowView(model: post, isMyPage: true)
                            }
                            Divider()
                        }
                    }
                }
                .padding(20)
                .padding(.bottom, 50)
                Spacer()
            }
            .padding(.top, 10)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButtonBlack()
                }
                ToolbarItem(placement: .principal) {
                    Text("내가 저장한 글")
                        .font(.semibold18)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    MyBookmarksView()
}

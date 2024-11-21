//
//  MyPostsView.swift
//  TeamUP
//
//  Created by Hwang_Inyoung on 11/21/24.
//

import SwiftUI

struct MyPostsView: View {
    @State private var selectedTab = 0
    @State private var searchText = ""
    
    // 홈 글 데이터
    let homePosts: [Post] = [
        Post(
            category: .study,
            user: User(id: "1", email: "test@test.com", password: "123", nickname: "수민", profileImageName: "default.png"),
            isRecruit: true,
            title: "알고리즘 스터디",
            content: "초보 환영하고 간혹 친목도 해요 연락주세요!",
            time: "1분 전",
            save: 12,
            seen: 13,
            maxCapacity: 10,
            currentCapacity: 5,
            hasTag: ["알고리즘"]
        ),
        Post(
            category: .project,
            user: User(id: "2", email: "test2@test.com", password: "123", nickname: "원호", profileImageName: "default.png"),
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
    
    // 라운지 글 데이터
    let loungePosts: [Rounge] = [
        Rounge(
            category: .qna,
            user: User(id: "3", email: "test3@test.com", password: "123", nickname: "소영", profileImageName: "default.png"),
            title: "질문 있습니다!",
            content: "프로젝트 마감 일정은 어떻게 조율하시나요?",
            reply: [],
            time: "2시간 전",
            save: 10,
            seen: 8,
            hasTag: ["질문"]
        )
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                
                
                // 탭 전환
                Picker("Tabs", selection: $selectedTab) {
                    Text("홈").tag(0)
                    Text("라운지").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                Divider()
                
                // 검색창
                CustomSearchBar(searchText: $searchText, placeholder: "검색어를 입력하세요") { query in
                    // 검색 로직
                }
                .padding(.horizontal)
                
                // 리스트
                List {
                    if selectedTab == 0 {
                        // 홈 탭
                        ForEach(homePosts.filter {
                            searchText.isEmpty || $0.title.contains(searchText)
                        }) { post in
                            NavigationLink(destination: HomeLoungeDetailView(model: post)) {
                                ListRowView(model: post, isMyPage: true)
                            }
                        }
                    } else {
                        // 라운지 탭
                        ForEach(loungePosts.filter {
                            searchText.isEmpty || $0.title.contains(searchText)
                        }) { post in
                            NavigationLink(destination: HomeLoungeDetailView(model: post)) {
                                ListRowView(model: post, isMyPage: true)
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            //        .navigationTitle("")
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonBlack()
            }
        }
    }
}

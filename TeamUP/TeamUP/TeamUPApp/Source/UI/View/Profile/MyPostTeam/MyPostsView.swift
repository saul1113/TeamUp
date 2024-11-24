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
    @Environment(PostViewModel.self) private var postViewModel: PostViewModel
    @Environment(AuthManager.self) private var authManager: AuthManager
    
    /*
     // 홈 글 데이터
     @State private var homePosts: [Post] = [
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
     @State private var loungePosts: [Rounge] = [
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
     ),
     Rounge(
     category: .qna,
     user: User(id: "4", email: "test4@test.com", password: "123", nickname: "승호", profileImageName: "default.png"),
     title: "질문 있습니다!",
     content: "다들 지치고 힘들 때 어떻게 하나요?",
     reply: [],
     time: "5시간 전",
     save: 10,
     seen: 8,
     hasTag: ["질문"]
     )
     ]
     */
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                HStack (alignment: .bottom,spacing: 0) {
                    Button(action: {                            selectedTab = 0
                    }) {
                        VStack(spacing: 5) {
                            Text("홈")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(selectedTab == 0 ? .black : .gray)
                            Rectangle()
                                .fill(selectedTab == 0 ? Color.customBlue : Color.gray)
                                .frame(height:selectedTab == 0 ? 3 : 0.4)
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
                                .frame(height:selectedTab == 1 ? 3 : 0.4)
                        }
                    }
                }
                .font(.semibold20)
                .padding(.horizontal, 20)
                
                if let currentUserID = authManager.user?.email {
                    ScrollView {
                        if selectedTab == 0 {
                            // 홈 탭
                            ForEach(postViewModel.posts.filter { post in
                                (searchText.isEmpty || post.title.contains(searchText)) &&
                                post.user.email == currentUserID
                            }, id: \.id) { post in
                                NavigationLink(destination: HomeLoungeDetailView(model: post)) {
                                    ListRowView(model: post, isMyPage: true)
                                }
                                Divider()
                            }
                        } else {
                            // 라운지 탭
                            ForEach(postViewModel.posts.filter { post in
                                (searchText.isEmpty || post.title.contains(searchText)) &&
                                post.categoryString == "라운지" &&
                                post.user.email == currentUserID
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
                    .onAppear {
                        // 디버깅 로그 추가
                        print("AuthManager User Email: \(currentUserID)")
                        print("All Post User Emails: \(postViewModel.posts.map { $0.user.email })")
                    }
                } else {
                    Text("사용자 이메일을 불러올 수 없습니다.")
                        .onAppear {
                            // 디버깅 로그 추가
                            print("user = \(authManager.user?.email)")
                            print("All Post User Emails: \(postViewModel.posts.map { $0.user.email })")
                        }
                }
                Spacer()
            }
            .padding(.top,10)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButtonBlack()
                }
                ToolbarItem(placement: .principal) {
                    Text("내가 쓴 글")
                        .font(.semibold18)
                        .foregroundColor(.black)
                }
            }
        }
        .onAppear {
            if authManager.user == nil {
                authManager.fetchUserInfo { result in
                    switch result {
                    case .success(let user):
                        print("User loaded: \(user.email)")
                    case .failure(let error):
                        print("Failed to load user: \(error)")
                    }
                }
            }
        }
    }
}

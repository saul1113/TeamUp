//
//  Profile.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI

struct MyProfileView: View {
    @Environment(AuthManager.self) private var authManager: AuthManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var tags: [String] = ["iOS", "앱개발"]
    @State private var link: [String] = ["https://likelion.notion.site", "https://github.com", "https://example.com"]
    @State private var showLogoutAlert: Bool = false
    @State private var showDeleteAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray.opacity(0.3))
                            .padding(.trailing, 10)
                        
                        if let user = authManager.user {
                            Text(user.nickname)
                                .font(.semibold18)
                        } else {
                            Text("로그인 필요")
                                .font(.semibold22)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        
                        NavigationLink(destination: EditView()) {
                            Text("프로필 수정")
                                .frame(width: 80, height: 40)
                                .font(.semibold14)
                                .foregroundColor(.white)
                                .background(Color.customBlue)
                                .cornerRadius(5)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 5)
                    
                    Text("소개")
                        .font(.semibold18)
                    
                    if let user = authManager.user {
                        Text(user.bio ?? "")
                            .font(.regular16)
                    } else {
                        Text("소개글이 비어있습니다")
                            .foregroundStyle(.customDarkGray)
                    }
                    
                    Spacer()
                    
                    Text("관심분야")
                        .font(.semibold18)
                    
                    TagViewX(tags: $tags)
                    
                    Spacer()
                    
                    Text("링크")
                        .font(.semibold18)
                    
                    ForEach(link, id: \.self) { linkURL in
                        HStack {
                            if linkURL.contains("notion") {
                                Image("LinkIcon/notionIcon")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 5)
                                
                                Link("Notion", destination: URL(string: linkURL) ?? URL(string: "https://www.notion.so/ko")!)
                                    .foregroundStyle(.customBlue)
                                
                            } else if linkURL.contains("github") {
                                Image("LinkIcon/githubIcon")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 5)
                                
                                Link("GitHub", destination: URL(string: linkURL) ?? URL(string: "https://github.com")!)
                                    .foregroundStyle(.customBlue)
                                
                            } else {
                                Image(systemName: "link")
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.black)
                                
                                Link(linkURL, destination: URL(string: linkURL)!)
                                    .foregroundStyle(.customBlue)
                            }
                        }
                        .font(.regular18)
                    }
                    
                    Spacer().frame(height: 3)
                    
                    Rectangle()
                        .fill(Color.gray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                    
                    VStack (alignment: .leading, spacing: 20) {
                        NavigationLink(destination: MyPostsView()) {
                            HStack {
                                Text("내가 쓴 글")
                                    .padding(.top, 12)
                            }
                        }
                        
                        Divider()
                        
                        NavigationLink(destination: MyBookmarksView()) {
                            HStack {
                                Text("내가 저장한 글")
                            }
                        }
                        
                        Divider()
                        
                        
                        NavigationLink(destination: MyRecruitingTeamsView()) {
                            HStack {
                                Text("내가 모집 중인 팀")
                                    .font(.semibold18)
                            }
                        }
                        
                        Divider()
                        
                        NavigationLink(destination: MyAppliedTeamsView()) {
                            HStack {
                                Text("내가 신청한 팀")
                                    .font(.semibold18)
                                    .padding(.bottom, 12)
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .font(.semibold18)
                    .foregroundStyle(.black)
                    
                    Divider()
                    
                    VStack (alignment: .leading, spacing: 20){
                        
                        Text("기타")
                            .font(.semibold18)
                            .padding(.top, 15)
                        
                        NavigationLink("자주 묻는 질문", destination: QuestionView())
                        
                        NavigationLink("이용약관", destination: TermsAndConditionsView())
                        
                        NavigationLink("개인정보처리방침", destination: PrivacyPolicyView())
                        
                        Button("로그아웃") {
                            showLogoutAlert.toggle()
                        }
                        .font(.regular16)
                        .foregroundStyle(.red)
                        .alert(isPresented: $showLogoutAlert) {
                            Alert(
                                title: Text("로그아웃"),
                                message: Text("정말 로그아웃 하시겠습니까?"),
                                primaryButton: .destructive(Text("로그아웃")) {
                                    authManager.logout() // 로그아웃 실행
                                },
                                secondaryButton: .cancel(Text("취소"))
                            )
                        }
                        
                        Divider()
                        
                        Button("회원탈퇴") {
                            showDeleteAlert.toggle()
                        }
                        .padding(.bottom, 50)
                        .font(.regular16)
                        .foregroundStyle(.customDarkGray)
                        .alert(isPresented: $showDeleteAlert) {
                            Alert(
                                title: Text("회원탈퇴"),
                                message: Text("정말 회원탈퇴 하시겠습니까?"),
                                primaryButton: .destructive(Text("회원탈퇴")) {
                                    authManager.deleteAccount()
                                },
                                secondaryButton: .cancel(Text("취소"))
                            )
                        }
                    }
                    .font(.regular16)
                    .foregroundStyle(.black)
                }
                .padding(20)
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        MyProfileView()
    }
    .environment(AuthManager())
}

//
//  Profile.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI

struct MyProfileView: View {
    //    @EnvironmentObject var authManager: AuthManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var nickname: String = "수민이다"
    @State private var selfPR: String = "안녕하세요 김수민입니다~ 팀업 화이팅 !"
    @State private var tags: [String] = ["iOS", "앱개발"]
    @State private var linkName: String = "노션"
    @State private var link: String = "www.example.com"
    
    init() {
        UINavigationBar.appearance().backgroundColor = .customBlue
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.backgroundColor = UIColor.customBlue
            navBarAppearance.shadowColor = .gray
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().compactAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
//                    HStack {
//                        Spacer()
//                        ShareLink(
//                            item: "TeamUpApp://MyProfile",
//                            subject: Text("TeamUpApp"),
//                            message: Text("프로필 공유")) {
//                                Image(systemName: "square.and.arrow.up")
//                                    .font(.title2)
//                                    .padding(.top, 10)
//                                    .padding(.leading, 20)
//                            }
//                    }
                    HStack(alignment: .center) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray.opacity(0.3))
                            .padding(.trailing, 10)
                        
                        Text("\(nickname)")
                            .font(.semibold22)
                        
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
                        .frame(height: 10)
                    
                    Text("소개")
                        .font(.semibold22)
                    Text("\(selfPR)")
                        .font(.regular16)
                    
                    Spacer()
                    
                    Text("관심분야")
                        .font(.semibold22)
                    
                    TagViewX(tags: $tags)
                    
                    Spacer()
                    
                    Text("링크")
                        .font(.semibold22)
                    HStack {
                        Image("LinkIcon/notionIcon")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 5)
                        
                        Link(linkName, destination: URL(string: link) ?? URL(string: "https://likelion.notion.site/iOS-6-9e9fde30b6e74d58aa4ef9864c7ed093")!)
                            .font(.regular18)
                            .underline()
                    }
                    
                    Spacer().frame(height: 3)
                    
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: .infinity , height: 3)
                    
                    VStack (alignment: .leading, spacing: 20) {
                        Text("내가 쓴 글")
                            .font(.semibold18)
                        
                        Divider()
                        
                        Text("내가 모집 중인 팀")
                            .font(.semibold18)
                        
                        Divider()
                        
                        Text("내가 신청한 팀")
                            .font(.semibold18)
                    }
                    
                    Divider()
                    
                    VStack (alignment: .leading, spacing: 20){
                        
                        Text("기타")
                            .font(.semibold18)
                        
                        NavigationLink("공지사항", destination: AnnouncementView())
                        
                        NavigationLink("자주 묻는 질문", destination: QuestionView())
                        
                        NavigationLink("설정", destination: SettingView())
                        
                        NavigationLink("이용약관", destination: TermsAndConditionsView())
                        
                        NavigationLink("개인정보처리방침", destination: PrivacyPolicyView())
                        Button("로그아웃") {
                            // authManager.logout()
                        }
                    }
                    .font(.regular16)
                    .foregroundStyle(.black)
                }
                .padding(20)
            }
        }
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                
//                ShareLink(
//                    item: "TeamUpApp://MyProfile",
//                    subject: Text("TeamUpApp"),
//                    message: Text("프로필 공유")) {
//                        Image(systemName: "square.and.arrow.up")
//                    }
//            }
//        }
    }
}

#Preview {
    NavigationStack {
        MyProfileView()
    }
}

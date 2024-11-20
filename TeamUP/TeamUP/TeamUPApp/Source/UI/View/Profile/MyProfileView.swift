//
//  Profile.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI

struct MyProfileView: View {
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.presentationMode) var presentationMode
    

    @State private var tags: [String] = ["iOS", "앱개발"]
    @State private var link: String = "www.example.com"
    @State private var linkName: String = "노션"
    @State private var showLogoutAlert: Bool = false
    
//    init() {
//        UINavigationBar.appearance().backgroundColor = .customBlue
//            let navBarAppearance = UINavigationBarAppearance()
//            navBarAppearance.backgroundColor = UIColor.customBlue
//            navBarAppearance.shadowColor = .gray
//            UINavigationBar.appearance().standardAppearance = navBarAppearance
//            UINavigationBar.appearance().compactAppearance = navBarAppearance
//            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
//        }
    
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
                        
                        // 닉네임 표시
                        if let user = authManager.user {
                            Text(user.nickname)
                                .font(.semibold22)
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
                        .frame(height: 10)
                    
                    Text("소개")
                        .font(.semibold22)
                    
                    if let user = authManager.user {
                        Text(user.bio)
                            .font(.regular16)
                    } else {
                        Text("소개 정보를 추가하세요.")
                    }
                    
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
                        
                        
                    }
                    .font(.regular16)
                    .foregroundStyle(.black)
                    
                    Divider()
                    
                    Button("로그아웃") {
                        showLogoutAlert.toggle()
                    }
                    .padding(.bottom, 50)
                    .font(.bold16)
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
                    
                }
                .padding(20)
                
            }
            
        }
// //        .toolbar {
// //            ToolbarItem(placement: .topBarTrailing) {
// //                
// //                ShareLink(
// //                    item: "TeamUpApp://MyProfile",
// //                    subject: Text("TeamUpApp"),
// //                    message: Text("프로필 공유")) {
// //                        Image(systemName: "square.and.arrow.up")
// //                    }
// //            }
// //        }
//         .toolbar {
//             ToolbarItem(placement: .topBarTrailing) {
                
//                 ShareLink(
//                     item: "TeamUpApp://MyProfile",
//                     subject: Text("TeamUpApp"),
//                     message: Text("프로필 공유")) {
//                         Image(systemName: "square.and.arrow.up")
//                     }
//             }
//         }
//         .onChange(of: authManager.isAuthenticated) { isAuthenticated in
//             // 로그아웃 상태일 때 스타트팀업뷰로 이동
//             if !isAuthenticated {
//                 presentationMode.wrappedValue.dismiss()
//             }
//         }
    }
    @ViewBuilder
    private func listItem(_ title: String, destination: () -> some View) -> some View {
        NavigationLink {
            destination()
        } label: {
            HStack {
                Text(title)
                    .font(.semibold18)
                    .foregroundStyle(.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
        }
        .listRowSeparator(.hidden)
    }
}

//#Preview {
//    NavigationStack {
//        MyProfileView()
//    }
//}

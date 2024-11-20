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
    @State private var selfPR: String = "소개소개소개소개"
    @State private var tags: [String] = ["iOS", "앱개발"]
    @State private var linkName: String = "노션"
    @State private var link: String = "www.example.com"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .center) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray.opacity(0.3))
                            .padding(.trailing, 10)
                        
                        Text("\(nickname)")
                            .font(.semibold22)
                        
                        Spacer()
                        
                        Button {
                            
                        } label : {
                            Text("프로필 수정")
                                .frame(width: 100, height: 45)
                                .font(.semibold18)
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
                        Text("\(linkName)")
                            .font(.regular18)
                        Text("\(link)")
                            .font(.regular16)
                    }
                    
                    Spacer()
                    
                                    List {
                                        listItem("공지사항") {
                                            AnnouncementView()
                                        }
                    
                                        listItem("자주 묻는 질문") {
                                            QuestionView()
                                        }
                    
                                        listItem("설정") {
                                            SettingView()
                                        }
                    
                                        listItem("이용약관") {
                                            TermsAndConditionsView()
                                        }
                    
                                        listItem("개인정보처리방침") {
                                            PrivacyPolicyView()
                                        }
                    
                                        Button("로그아웃") {
                                            //                    authManager.logout()
                                        }
                                        .font(.bold16)
                                        .foregroundStyle(.red)
                                    }
                                    .listStyle(.plain)
                                    .environment(\.defaultMinListRowHeight, 0)
                                    .font(.semibold18)
                                    .padding(-20)
                }
                .padding(20)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                
                ShareLink(
                    item: "TeamUpApp://MyProfile",
                    subject: Text("TeamUpApp"),
                    message: Text("프로필 공유")) {
                        Image(systemName: "square.and.arrow.up")
                    }
            }
        }
        //        .onChange(of: authManager.isAuthenticated) { isAuthenticated in
        //            // 로그아웃 상태일 때 스타트팀업뷰로 이동
        //            if !isAuthenticated {
        //                presentationMode.wrappedValue.dismiss()
        //            }
        //        }
        
        
    }
    
        @ViewBuilder
        private func listItem(_ title: String, destination: () -> some View) -> some View {
            NavigationLink {
                destination()
            } label: {
                Text(title)
            }
            .listRowSeparator(.hidden)
    
            Divider()
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
        }
}

#Preview {
    NavigationStack {
        MyProfileView()
    }
}

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
                        
                        Button {
                            // 프로필 수정 액션
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
                        Text("\(linkName)")
                            .font(.regular18)
                        
                        Text("\(link)")
                            .font(.regular16)
                    }
                    
                    Spacer()
                    
                    Button("로그아웃") {
                        showLogoutAlert.toggle()
                    }
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
                    
                    
                    // 리스트 섹션
                    VStack(spacing: 16) {
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
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 50)
                }
                .padding(20)
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(.black)
                }
            }
        }
        .onChange(of: authManager.isAuthenticated) { isAuthenticated in
            // 로그아웃 상태일 때 스타트팀업뷰로 이동
            if !isAuthenticated {
                presentationMode.wrappedValue.dismiss()
            }
        }
        
        
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
    
    //    @ViewBuilder
    //    private func listItem(_ title: String, destination: () -> some View) -> some View {
//        NavigationLink {
//            destination()
//        } label: {
//            Text(title)
//        }
//        .listRowSeparator(.hidden)
//
//        Divider()
//            .listRowInsets(EdgeInsets())
//            .listRowSeparator(.hidden)
//    }
}

//#Preview {
//    NavigationStack {
//        MyProfileView()
//    }
//}

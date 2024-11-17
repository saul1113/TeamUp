//
//  Profile.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI

struct ProfileView: View {
    private let padding: CGFloat = 20
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80))
                
                VStack(alignment: .leading) {
                    Text("유저")
                        .font(.semibold24)
                    
                    Text("프론트엔드인데 백엔드가 좋아요\n근데 C밖에 못해요 데려가주세요🐱\n안데려가면 물거임")
                        .font(.medium16)
                }
            }
            .padding(.horizontal, padding)
            
            HStack(alignment: .center) {
                Text("#프론트엔드")
                    .font(.regular16)
                
                Text("#몰라백엔드")
                    .font(.regular16)
            }
            .padding(.horizontal, padding)
                
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
            }
            .listStyle(.plain)
            .listRowInsets(EdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding))
            .environment(\.defaultMinListRowHeight, 0)
            .font(.semibold18)
        }
        
        Button("로그아웃") {
            // TODO: 로그아웃 로직 연결
        }
        .font(.bold16)
        .foregroundStyle(.red)
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
        ProfileView()
    }
}

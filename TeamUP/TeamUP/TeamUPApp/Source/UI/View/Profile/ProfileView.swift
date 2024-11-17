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
        VStack(alignment: .leading) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .padding(.horizontal, padding - 10)
            
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
            }
            .listStyle(.plain)
            .listRowInsets(EdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding))
            .environment(\.defaultMinListRowHeight, 0)
            .font(.semibold18)
        }
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

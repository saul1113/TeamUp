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
                NavigationLink {
                    AnnouncementView()
                } label: {
                    Text("공지사항")
                }
                .listRowSeparator(.hidden)
                
                Divider()
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                
                NavigationLink {
                    QuestionView()
                } label: {
                    Text("자주 묻는 질문")
                }
                .listRowSeparator(.hidden)
                
                Divider()
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                
                NavigationLink {
                    SettingView()
                } label: {
                    Text("설정")
                }
                .listRowSeparator(.hidden)
                
                Divider()
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .listRowInsets(EdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding))
            .environment(\.defaultMinListRowHeight, 0)
            .font(.semibold18)
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}

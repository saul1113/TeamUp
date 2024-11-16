//
//  Profile.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        List {
            NavigationLink {
                AnnouncementView()
            } label: {
                Text("공지사항")
            }
            
            NavigationLink {
                Text("자주 묻는 질문")
            } label: {
                Text("자주 묻는 질문")
            }
        }
        .listStyle(.plain)
        .font(.semibold18)
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}

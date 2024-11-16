//
//  AnnouncementView.swift
//  TeamUP
//
//  Created by Jaemin Hong on 11/17/24.
// 

import Foundation
import SwiftUI

struct AnnouncementView: View {
    private let padding: CGFloat = 20
    private var announcements: [AnnouncementDetailView] = [
        AnnouncementDetailView(item: AnnouncementModel(title: "[공지] 공지사항 - 1", content: "이건 공지사항일걸요..?", createAt: "2024.11.17")),
        AnnouncementDetailView(item: AnnouncementModel(title: "[공지] 공지사항 - 2", content: "이건 공지사항이었나 모르겠네", createAt: "2124.11.17")),
        AnnouncementDetailView(item: AnnouncementModel(title: "[공지] 공지사항 - 3", content: "이건 공지사", createAt: "1024.11.17")),
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("공지사항")
                .font(.bold24)
            
            List(announcements, id: \.item.id) { announcement in
                NavigationLink {
                    announcement
                } label: {
                    Text(announcement.item.title)
                        .font(.semibold18)
                }
            }
            .padding(.horizontal, -padding)
            .listStyle(.plain)
        }
        .padding(.horizontal, padding)
        .navigationTitle("공지사항")
        .backButton()
    }
}

#Preview {
    NavigationStack {
        AnnouncementView()
    }
}

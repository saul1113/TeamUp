//
//  AnnouncementDetailView.swift
//  TeamUP
//
//  Created by Jaemin Hong on 11/17/24.
//

import SwiftUI

struct AnnouncementDetailView: View {
    private(set) var item: AnnouncementModel
    private let padding: CGFloat = 20
    
    init(item: AnnouncementModel) {
        self.item = item
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(item.title)
                .font(.bold24)
            
            Text(item.createAt)
                .font(.semibold16)
                .foregroundStyle(.secondary)
            
            Divider()
                .padding(.horizontal, -padding)
            
            ScrollView {
                Text(item.content)
                    .font(.regular18)
            }
            
            Spacer()
        }
        .padding(.horizontal, padding)
        .navigationTitle("공지사항")
        .backButton()
    }
}

#Preview {
    NavigationStack {
        AnnouncementDetailView(item: AnnouncementModel(title: "공지사항", content: "고오오옹지지지ㅣㅈ하항", createAt: "2024.11.17"))
    }
}

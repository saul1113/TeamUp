//
//  AnnouncementView.swift
//  TeamUP
//
//  Created by Jaemin Hong on 11/17/24.
// 

import SwiftUI

struct AnnouncementView: View {
    private let contents: [InformationDetailView] = [
        InformationDetailView(item: InformationModel(title: "[공지] 공지 1번", content: "이건 공지일까..?😗", createAt: "2024.11.17")),
        InformationDetailView(item: InformationModel(title: "[공지] 공지 2번", content: "흠..훔..옹", createAt: "2024.11.17")),
        InformationDetailView(item: InformationModel(title: "[공지] 공지 3번", content: "오초", createAt: "2024.11.17")),
    ]
    
    var body: some View {
        InformationView(title: "공지사항", contents: contents)
    }
}

#Preview {
    NavigationStack {
        AnnouncementView()
    }
}

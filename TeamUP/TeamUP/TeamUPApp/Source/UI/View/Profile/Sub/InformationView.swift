//
//  AnnouncementView.swift
//  TeamUP
//
//  Created by Jaemin Hong on 11/17/24.
// 

import Foundation
import SwiftUI

struct InformationView: View {
    private let padding: CGFloat = 20
    private var title: String = ""
    private var contents: [InformationDetailView] = []
    
    init(title: String, contents: [InformationDetailView]) {
        self.title = title
        self.contents = contents
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.bold24)
            
            List(contents, id: \.item.id) { content in
                NavigationLink {
                    content
                } label: {
                    Text(content.item.title)
                        .font(.semibold18)
                }
            }
            .padding(.horizontal, -padding)
            .listStyle(.plain)
        }
        .padding(.horizontal, padding)
        .navigationTitle(title)
        .backButton()
    }
}

#Preview {
    NavigationStack {
        InformationView(title: "공지사항", contents: [
            InformationDetailView(item: InformationModel(title: "[공지]", content: "공지사항 - 1", createAt: "2024.11.17"))
        ])
    }
}

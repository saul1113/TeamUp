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
                .padding(.horizontal, padding)
            
            List(contents, id: \.item.id) { content in
                ExpandedDividerWithVStackView {
                    NavigationLink {
                        content
                            .navigationTitle(title)
                            .backButton()
                    } label: {
                        Text(content.item.title)
                            .font(.semibold18)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .listRowInsets(EdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding))
        }
        .navigationTitle(title)
        .backButton()
    }
}

#Preview {
    NavigationStack {
        InformationView(title: "공지사항", contents: [
            InformationDetailView(item: InformationModel(title: "[공지]", content: "공지사항 - 1", createAt: "2024.11.17")),
            InformationDetailView(item: InformationModel(title: "[공지]", content: "공지사항 - 1", createAt: "2024.11.17"))
        ])
    }
}

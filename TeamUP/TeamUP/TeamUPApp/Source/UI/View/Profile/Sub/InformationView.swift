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
    @StateObject private var viewModel = AnnouncementViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.bold24)
                .padding(.horizontal, padding)
            
            List(viewModel.announcementList) { item in
                NavigationLink {
                    InformationDetailView(item: item)
                        .navigationTitle(item.title)
                } label: {
                    Text(item.title)
                        .font(.semibold18)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .listRowInsets(EdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding))
        }
        .navigationTitle("공지사항")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem (placement: .topBarLeading) {
                BackButtonBlack()
            }
        }
    }
}

#Preview {
    NavigationStack {
        InformationView()
    }
}

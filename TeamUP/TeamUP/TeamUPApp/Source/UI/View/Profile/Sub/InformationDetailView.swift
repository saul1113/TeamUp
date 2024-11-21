//
//  AnnouncementDetailView.swift
//  TeamUP
//
//  Created by Jaemin Hong on 11/17/24.
//

import SwiftUI

struct InformationDetailView: View {
    private(set) var item: InformationModel
    private let padding: CGFloat = 20
    
    init(item: InformationModel) {
        self.item = item
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(item.title)
                .font(.bold20)
            
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
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem (placement: .topBarLeading) {
                BackButtonBlack()
            }
        }
    }
}

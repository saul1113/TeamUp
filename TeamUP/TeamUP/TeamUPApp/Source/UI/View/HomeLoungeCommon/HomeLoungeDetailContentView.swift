//
//  PostDetailContentView.swift
//  TeamUP
//
//  Created by wonhoKim on 11/18/24.
//

import SwiftUI

struct HomeLoungeDetailContentView: View {
    var model: Listable
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                // 게시글 제목
                Text(model.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                // 게시글 내용 // 이거도 마크다운으로 보여줘야할지도
                Text(model.content)
                    .font(.body)
                    .foregroundColor(.black.opacity(0.8))
                    .lineSpacing(6)//행간
                    .kerning(0.5) // 자간
                    .padding(.vertical, 5)
                    .lineLimit(nil)
            }
            
            
        }
        
        
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(model.hasTag, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(4)
                }
            }
        }
    }
}

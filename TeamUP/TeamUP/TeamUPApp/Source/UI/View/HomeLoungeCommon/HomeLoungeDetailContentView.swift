//
//  PostDetailContentView.swift
//  TeamUP
//
//  Created by wonhoKim on 11/18/24.
//

import SwiftUI
import MarkdownUI
struct HomeLoungeDetailContentView: View {
    var model: Listable
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20){
            // 게시글 제목
            Text(model.title)
                .font(.bold24)
                .fontWeight(.bold)
            
            let markDownContent = model.content
            // 게시글 내용 // 이거도 마크다운으로 보여줘야할지도
            Markdown(markDownContent)
                .font(.regular16)
            
            
        }
        
        
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 8) {
//                ForEach(model) { tag in
//                    Text(tag)
//                        .font(.system(size: 12))
//                        .padding(8)
//                        .background(Color.gray.opacity(0.1))
//                        .cornerRadius(8)
//                }
//            }
//        }
    }
}

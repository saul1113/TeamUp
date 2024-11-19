//
//  TagView.swift
//  TeamUP
//
//  Created by 김수민 on 11/19/24.
//

import SwiftUI


//https://medium.com/geekculture/tags-view-in-swiftui-e47dc6ce52e8 참고.

struct TagView: View {
    @Binding var tags: [String]
    @State private var newTag: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
//            TextField("태그를 입력한 후 엔터를 눌러주세요", text: $newTag, onCommit: {
//                addTag()
//            })
//            .font(.system(size: 16))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tags, id: \.self) { tag in
                        HStack {
                            Text(tag)
                                .font(.system(size: 16))
                            
                            Button {
                                removeTag(tag)
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
            }
        }
    }
    
    func removeTag(_ tag: String) {
        if let index = tags.firstIndex(of: tag) {
            tags.remove(at: index)
        }
    }
}

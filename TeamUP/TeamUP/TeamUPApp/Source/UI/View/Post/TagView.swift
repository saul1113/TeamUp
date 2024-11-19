//
//  TagView.swift
//  TeamUP
//
//  Created by 김수민 on 11/19/24.
//

import SwiftUI


//https://medium.com/geekculture/tags-view-in-swiftui-e47dc6ce52e8 참고함.

struct TagView: View {
    @State private var tagText: String = ""

    @State private var tags: [String] = []
    
    var body: some View {
        VStack {
            
            TextField("엔터를 입력하여 태그를 등록할 수 있습니다 (최대 5개)", text: $tagText, onCommit: {

                addTag()
            })
            .font(.regular14)

            HStack(spacing: 4) {
                ForEach(tags, id: \.self) { tag in
                    HStack(spacing: 6) {
                        Text(tag)
                            .font(.regular14)
                            .foregroundStyle(.customBlue)
                            .padding(.leading, 10)
                            .padding(.trailing, 30)
                            .padding(.vertical, 8)
                            .background(
                                ZStack(alignment: .trailing) {
                                    Capsule()
                                        .fill(Color.gray.opacity(0.1))
                                    Button {
                                        removeTag(tag)
                                    } label: {
                                        Image(systemName: "xmark")
                                            .font(.system(size: 12))
                                            .padding(.trailing, 10)
                                            .foregroundColor(.black)
                                    }
                                }
                            )
                    }
                    .frame(height: 28)
                }
            }
        }
    }
    
    func addTag() {
        guard !tagText.isEmpty else { return }
        tags.append(tagText)
        tagText = ""
    }

    func removeTag(_ tag: String) {
        if let index = tags.firstIndex(of: tag) {
            tags.remove(at: index)
        }
    }
}

#Preview {
    TagView()
}

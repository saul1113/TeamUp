//
//  PostView.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI
import MarkdownUI

struct PostView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(PostViewModel.self) private var postViewModel: PostViewModel
    
    @State private var postCategory = "프로젝트 모집"
    let categories = ["프로젝트 모집", "스터디 모집", "Q & A", "잡담"]
    
    @State private var postTitle: String = ""
    @State private var isPreviewMode = false
    @State private var markdownText: String = ""
    @State private var tags: [String] = []
    @State private var newTag: String = ""
    @State private var selectedTab: CategoryTab = .project
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
                Spacer()
                Button(action: {
                }) {
                    Text("임시저장")
                        .foregroundColor(.black)
                        .font(.body)
                }
            }
            .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    CategorySelectedView(selectedTab: $selectedTab)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 10)
                    
                    TextField("제목을 입력하세요", text: $postTitle)
                        .background(Color.clear)
                        .font(.semibold26)
                    
                    TextField("태그를 입력한 후 엔터를 눌러주세요", text: $newTag, onCommit: {
                        addTag()
                    })
                    .font(.system(size: 16))
                    
                    TagView(tags: $tags)
                    
                    ToggleButtonView(isPreviewMode: $isPreviewMode)
                        .padding(.top, 20)
                }
                
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 0.3)
                        .frame(width: 370, height: 500)
                    
                    if isPreviewMode {
                        Markdown(markdownText)
                            .padding(25)
                    } else {
                        TextEditorView(markdownText: $markdownText)
                    }
                }
            }
            .padding(.horizontal)
            
            Button {
                Task {
                    let post = PostModelStruct(category: selectedTab.rawValue == 0 ? "프로젝트" : "스터디", title: postTitle, content: markdownText, maxUserCount: 15)
                    try await postViewModel.addPost(post)
                    try await postViewModel.fetchPosts { result in
                        switch result {
                        case .success(let data):
                            postViewModel.setData(posts: data)
                        case .failure(let error):
                            print(error)
                        }
                    }
                    dismiss()
                }
            } label: {
                Text("작성 완료")
                    .frame(width: 360, height: 50)
                    .font(.semibold20)
                    .foregroundColor(.white)
                    .background(Color.customBlue)
                    .cornerRadius(4)
            }
            .padding(.bottom, 20)
        }
        .background(Color.white.ignoresSafeArea())
    }
    
    func addTag() {
        if !newTag.isEmpty {
            tags.append(newTag)
            newTag = ""
        }
    }
}

#Preview {
    PostView()
        .environment(PostViewModel())
}

//
//  EditView.swift
//  TeamUP
//
//  Created by 김수민 on 11/19/24.
//

import SwiftUI

struct EditView: View {
    @State private var nickname: String = ""
    @State private var selfPR: String = ""
    @State private var newTag: String = ""
    @State private var tags: [String] = []
    @State private var linkName: String = ""
    @State private var link: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray.opacity(0.3))
                                .overlay(
                                    Image(systemName: "camera.fill")
                                        .resizable()
                                        .frame(width: 28, height: 24)
                                        .offset(x: 40, y: 28)
                                        .foregroundColor(.gray)
                                )
                        }
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    Text("닉네임")
                        .font(.semibold18)
                    TextField("수민이다", text: $nickname)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.regular14)
                    
                    Spacer()
                    
                    Text("소개")
                        .font(.semibold18)
                    TextField("본인을 자유롭게 글로 표현해주세요", text: $selfPR)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.regular14)
                    
                    Spacer()
                    
                    Text("관심분야")
                        .font(.semibold18)
                    
                    
                    TextField("관심분야를 입력한 후 엔터를 눌러주세요 (최대 5개)", text: $newTag, onCommit: {
                        addTag()
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.regular14)
                    
                    
                    TagView(tags: $tags)
                     
                    Spacer()
                    
                    
                    Text("링크")
                        .font(.semibold18)
                    HStack {
                        TextField("표시할 이름", text: $linkName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.regular14)
                        TextField("URL 주소", text: $link)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.regular14)
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(20)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                XMarkButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Text("완료")
                        .fontWeight(.regular)
                        .foregroundColor(.black)
                }
            }
        }
        .navigationTitle("프로필 수정")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addTag() {
        if !newTag.isEmpty {
            tags.append(newTag)
            newTag = ""
        }
    }
}

#Preview {
    EditView()
}

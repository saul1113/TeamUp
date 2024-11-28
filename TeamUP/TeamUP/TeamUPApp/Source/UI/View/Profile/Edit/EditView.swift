//
//  EditView.swift
//  TeamUP
//
//  Created by 김수민 on 11/19/24.
//

import SwiftUI

struct EditView: View {
    @Environment(AuthManager.self) private var authManager: AuthManager
    @Environment(\.dismiss) var dismiss
    
    @State private var nickname: String = ""
    @State private var selfPR: String = ""
    @State private var newTag: String = ""
    @State private var tags: [String] = []
    @State private var link: [String] = []
    @State private var linkName: String = ""
    @State private var profileImage: UIImage = UIImage()
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    HStack {
                        Spacer()
                        VStack {
                            Button(action: {
                                isPresented = true
                            }) {
                                ZStack {
                                    if profileImage != UIImage() {
                                        Image(uiImage: profileImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipShape(.circle)
                                        
                                    } else {
                                        Image(systemName: "person.crop.circle.fill")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(.gray.opacity(0.3))
                                        
                                        Image(systemName: "camera.fill")
                                            .resizable()
                                            .frame(width: 28, height: 24)
                                            .offset(x: 40, y: 28)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            Text("\(nickname)")
                                .font(.semibold22)
                                .padding(.top, 15)
                        }
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    
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
                    
                    VStack (alignment: .leading){
                        ForEach(link, id: \.self) { linkURL in
                            HStack {
                                Text(linkURL)
                                    .font(.regular16)
                                Button(action: {
                                    removeLink(linkURL)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.customRed)
                                }
                            }
                        }
                        
                        HStack {
                            TextField("URL 주소를 입력해주세요", text: $linkName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .font(.regular14)
                            
                            Button(action: {
                                addLink()
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        Task {
                            try await authManager.updateUserProfile(nickname: nickname, bio: selfPR/*, interests: tags, links: link*/) { result in
                                switch result {
                                case .success(let updatedUser):
                                    dismiss()
                                case .failure(let error):
                                    print("\(error.localizedDescription)")
                                }
                            }
                            dismiss()
                        }
                    } label: {
                        Text("수정 완료")
                            .frame(width: 360, height: 50)
                            .font(.semibold20)
                            .foregroundColor(.white)
                            .background(Color.customBlue)
                            .cornerRadius(4)
                    }
                    .padding(.bottom, 20)
                }
            }
        }
        .padding(20)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                XMarkButton()
            }
            ToolbarItem(placement: .principal) {
                Text("프로필 수정")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if let user = authManager.user {
                nickname = user.nickname
                selfPR = user.bio ?? ""
                // tags = user.interests
                // linkName = user.linkName
                // link = user.link
            }
        }
        .sheet(isPresented: $isPresented) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$profileImage)
        }
    }
    
    func addTag() {
        if !newTag.isEmpty {
            tags.append(newTag)
            newTag = ""
        }
    }
    
    func addLink() {
        if !linkName.isEmpty {
            link.append(linkName)
            linkName = ""
        }
    }
    
    func removeLink(_ linkURL: String) {
        if let index = link.firstIndex(of: linkURL) {
            link.remove(at: index)
        }
    }
}

#Preview {
    EditView()
}

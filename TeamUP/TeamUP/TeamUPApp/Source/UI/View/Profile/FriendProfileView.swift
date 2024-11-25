//
//  FriendProfileView.swift
//  TeamUP
//
//  Created by 김수민 on 11/20/24.
//

import SwiftUI

struct FriendProfileView: View {
    @Environment(AuthManager.self) private var authManager: AuthManager
    
    @State private var tags: [String] = ["iOS", "앱개발"]
    @State private var linkName: String = "노션"
    @State private var link: String = "www.example.com"
    
    var friend: User?
    private var defaultUser: User {
        User(id: UUID().uuidString, email: "unknown@example.com", password: "", nickname: "알 수 없는 사용자", profileImageName: "", bio: "소개글이 없습니다")
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .center) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray.opacity(0.3))
                            .padding(.trailing, 10)
                        
                        
                        Text(friend?.nickname ?? defaultUser.nickname)
                            .font(.semibold22)
                        
                        Spacer()
                        
                        Button {
                            
                        } label : {
                            Text("1:1 채팅")
                                .frame(width: 100, height: 45)
                                .font(.semibold18)
                                .foregroundColor(.white)
                                .background(Color.customBlue)
                                .cornerRadius(5)
                        }
                    }
                    
                    Spacer().frame(height: 10)
                    
                    Text("소개")
                        .font(.semibold22)
                    
                    Text((friend?.bio ?? defaultUser.bio) ?? "")
                        .font(.regular16)
                    
                    Spacer()
                    
                    Text("관심분야")
                        .font(.semibold22)
                    
                    TagViewX(tags: $tags)
                    
                    Spacer()
                    
                    Text("링크")
                        .font(.semibold22)
                    
                    HStack {
                        Image("LinkIcon/notionIcon")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 5)
                        
                        Link(linkName, destination: URL(string: link) ?? URL(string: "https://likelion.notion.site/iOS-6-9e9fde30b6e74d58aa4ef9864c7ed093")!)
                            .font(.regular18)
                            .underline()
                    }
                    
                    Spacer()
                }
                .padding(20)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                BackButtonBlack()
            }
            ToolbarItem(placement: .topBarTrailing) {
                ShareLink(
                    item: "TeamUpApp://friends",
                    subject: Text("TeamUpApp"),
                    message: Text("프로필 공유")) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .foregroundStyle(.customBlue)
            }
        }
        .onAppear() {
            print("friend : \(friend)")
        }
    }
}

//#Preview {
//    FriendProfileView(friend: User(nickname: "수민이다", bio: "소개소개소개소개", tags: ["iOS", "앱개발"]))
//}

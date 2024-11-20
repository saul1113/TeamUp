//
//  FriendProfileView.swift
//  TeamUP
//
//  Created by 김수민 on 11/20/24.
//

import SwiftUI

struct FriendProfileView: View {
    //    @EnvironmentObject var authManager: AuthManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var nickname: String = "수민이다"
    @State private var selfPR: String = "소개소개소개소개"
    @State private var tags: [String] = ["iOS", "앱개발"]
    @State private var linkName: String = "노션"
    @State private var link: String = "www.example.com"
    
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
                        
                        Text("\(nickname)")
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
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Text("소개")
                        .font(.semibold22)
                    Text("\(selfPR)")
                        .font(.regular16)
                    
                    Spacer()
                    
                    Text("관심분야")
                        .font(.semibold22)
                    
                    TagViewX(tags: $tags)
                    
                    
                    Spacer()
                    
                    
                    Text("링크")
                        .font(.semibold22)
                    HStack {
                        Text("\(linkName)")
                            .font(.regular18)
                        Text("\(link)")
                            .font(.regular16)
                    }
                    
                    Spacer()
                }
                .padding(20)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                BackButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    FriendProfileView()
}

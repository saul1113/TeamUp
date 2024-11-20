//
//  ChatView.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI

struct ChatView: View {
    enum ChatTab: Int, CaseIterable {
        case privateChat
        case groupChat
    }
//    
//    init() {
//        UINavigationBar.appearance().backgroundColor = .customBlue
//            let navBarAppearance = UINavigationBarAppearance()
//            navBarAppearance.backgroundColor = UIColor.customBlue
//            navBarAppearance.shadowColor = .gray
//            UINavigationBar.appearance().standardAppearance = navBarAppearance
//            UINavigationBar.appearance().compactAppearance = navBarAppearance
//            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
//        }
    
    @State private var selectedTab: ChatTab = .groupChat
    var body: some View {
        NavigationStack {
            VStack (spacing: 20){
                chatSpliteView()
                switch selectedTab {
                case .privateChat:
                    PrivateChatListView()
                case .groupChat:
                    GroupChatListView()
                }
                Spacer()
            }
        }
    }
    func chatSpliteView() -> some View {
        HStack (alignment: .bottom,spacing: 0){
            Button {
                selectedTab = .groupChat
            }label: {
                VStack (spacing: 8) {
                    Text("그룹")
                        .frame(maxWidth: .infinity)
                    Rectangle()
                        .fill(selectedTab == .groupChat ? Color.customBlue : Color.gray)
                        .frame(height: selectedTab == .groupChat ? 3 : 0.4)
                }
            }
            Button {
                selectedTab = .privateChat
            }label: {
                VStack {
                    Text("개인")
                        .frame(maxWidth: .infinity)
                    Rectangle()
                        .fill(selectedTab == .privateChat ? Color.customBlue : Color.gray)
                        .frame(height:selectedTab == .privateChat ? 3 : 0.4)
                }
            }
        }
        .font(Font.semibold20)
        .foregroundStyle(.black)
        .padding(.horizontal, 16)
    }
}

#Preview {
    ChatView()
}

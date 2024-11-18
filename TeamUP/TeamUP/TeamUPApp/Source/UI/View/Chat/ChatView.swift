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
    @State private var selectedTab: ChatTab = .privateChat
    var body: some View {
        VStack {
            chatSpliteView()
            switch selectedTab {
            case .privateChat:
                Text("개인 채팅 뷰")
            case .groupChat:
                GroupChatView()
            }
            Spacer()
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

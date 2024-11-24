//
//  GroupChatView.swift
//  TeamUP
//
//  Created by Soom on 11/18/24.
//

import SwiftUI

struct GroupChatView: View {
    @State private var text: String = ""
    @Environment(ChatViewModel.self) private var chatViewModel: ChatViewModel
    @Environment(AuthManager.self) private var authManager: AuthManager
    let roomTitle: String
    let roomID: Int
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                
                Spacer()
                    .frame(height: 20)
                
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(chatViewModel.chatMessage[roomID]!.indices, id: \.self) { index in
                            messageView(message: chatViewModel.chatMessage[roomID]![index])
                                .id(index)
                        }
                    }
                    .onChange(of: chatViewModel.chatMessage[roomID]!) { _, _ in
                        print(chatViewModel.chatMessage.count)
                        if let lastMessageIndex = chatViewModel.chatMessage[roomID]!.indices.last {
                            withAnimation {
                                proxy.scrollTo(lastMessageIndex, anchor: .bottom)
                            }
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem (placement: .topBarLeading) {
                        BackButtonBlack()
                    }
                    
                    ToolbarItem (placement: .principal) {
                        Text(roomTitle)
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                    }
                    ToolbarItem (placement: .topBarTrailing) {
                        Button {
                            
                        }label: {
                            Image(systemName: "line.3.horizontal")
                                .resizable()
                                .frame(width: 20,height: 15)
                                .foregroundStyle(.black)
                        }
                    }
                }
                Divider()
                textField()
                
                Spacer()
                    .frame(height: 16)
            }
            .customPadding()
        }
    }
    func textField() -> some View {
        HStack {
            TextField("", text: $text)
                .padding(.vertical, 10)
                .padding(.leading, 10)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.gray, lineWidth: 0.5)
                }
            Button {
                chatViewModel.sendMessage(room: roomID, message: text)
                text = ""
            }label: {
                Image(systemName: "arrow.up.circle.fill")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .foregroundStyle(text.isEmpty ? .gray : Color.customBlue)
            }
            .disabled(text.isEmpty)
        }
        .customPadding()
    }
    
    @ViewBuilder
    func messageView(message: ChatMessage) -> some View {
        if let user = authManager.user {
            if message.user.email == user.email {
                HStack (alignment: .bottom, spacing: 5) {
                    Spacer()
                    Text(message.decodedDateString)
                        .font(Font.regular12)
                        .foregroundStyle(.gray)
                    Text(message.message)
                        .padding(.vertical, 12)
                        .customPadding()
                        .foregroundStyle(.black)
                        .background {
                            Rectangle()
                                .fill(Color.customBlue.opacity(0.5))
                                .cornerRadius(20, corners: [.topLeft, .bottomLeft, .bottomRight])
                        }
                }
            } else {
                HStack ( alignment: .bottom, spacing: 5) {
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 35,height: 35)
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    .padding(.trailing, -2)
                    VStack (alignment: .leading) {
                        Text(message.user.nickname)
                            .font(Font.semibold14)
                            .padding(.horizontal, 6)
                        Text(message.message)
                            .padding(.vertical, 12)
                            .customPadding()
                            .foregroundStyle(.black)
                            .background {
                                Rectangle()
                                    .fill(Color.customGray)
                                    .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                            }
                    }
                    Text(message.decodedDateString)
                        .font(Font.regular12)
                        .foregroundStyle(.gray)
                    Spacer()
                }
            }
        }
    }
}





#Preview {
    NavigationStack {
        GroupChatView(roomTitle: "봄날은 간다", roomID: 1)
    }
}

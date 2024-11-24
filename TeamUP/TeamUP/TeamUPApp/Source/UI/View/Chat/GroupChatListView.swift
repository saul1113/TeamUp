//
//  GroupChatView.swift
//  TeamUP
//
//  Created by Soom on 11/18/24.
//

import SwiftUI

struct GroupChatRoom: Identifiable {
    let id = UUID()
    let roomImage: Image
    let roomTitle: String
    let roomMember: Int
    let roomLastMessage: String
    let roomLastupdate: Date
    
    var decodedDateToString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        return formatter.string(from: roomLastupdate)
    }
    
    static let dummyData: [GroupChatRoom] = [
        GroupChatRoom(roomImage: Image(systemName: "person.crop.circle"), roomTitle: "알고리즘 스터디", roomMember: 7, roomLastMessage: "오늘 하루는 쉽싣다..", roomLastupdate: .now),
        GroupChatRoom(roomImage: Image(systemName: "person.crop.circle"), roomTitle: "TeamUP", roomMember: 10, roomLastMessage: "이렇게 했는데 어떤가요?", roomLastupdate: .now),
        GroupChatRoom(roomImage: Image(systemName: "person.crop.circle"), roomTitle: "TeamUP", roomMember: 7, roomLastMessage: "오늘 하루는 쉽싣다..", roomLastupdate: .now),
        GroupChatRoom(roomImage: Image(systemName: "person.crop.circle"), roomTitle: "TeamUP", roomMember: 10, roomLastMessage: "이렇게 했는데 어떤가요?", roomLastupdate: .now),
        GroupChatRoom(roomImage: Image(systemName: "person.crop.circle"), roomTitle: "TeamUP", roomMember: 7, roomLastMessage: "오늘 하루는 쉽싣다..", roomLastupdate: .now),
        GroupChatRoom(roomImage: Image(systemName: "person.crop.circle"), roomTitle: "TeamUP", roomMember: 10, roomLastMessage: "이렇게 했는데 어떤가요?", roomLastupdate: .now)
    ]
}
struct GroupChatListView: View {
    static private var firstLoad: Bool = true
    @State private var groupRooms: [GroupChatRoom] = GroupChatRoom.dummyData
    @Environment(AuthManager.self) private var authManager: AuthManager
    @Environment(ChatRoomViewModel.self) private var chatroomViewModel: ChatRoomViewModel
    @Environment(ChatViewModel.self) private var chatViewModel: ChatViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (alignment: .leading, spacing: 15) {
                    ForEach(chatroomViewModel.chatRooms, id: \.id) { room in
                        NavigationLink {
                            GroupChatView(roomTitle: room.name, roomID: room.id)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            GroupRoomView(room)
                        }
                        Rectangle()
                            .fill(.gray)
                            .frame(height: 0.3)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .onAppear {
            if GroupChatListView.firstLoad {
                Task {
                    try chatroomViewModel.fetchChatRooms()
                    chatViewModel.configureSocket(user: authManager.user) {
                        for room in chatroomViewModel.chatRooms {
                            chatViewModel.join(room.id)
                        }
                    }
                    
                    GroupChatListView.firstLoad = false
                }
            }
        }
        .refreshable {
            Task {
                try chatroomViewModel.fetchChatRooms()
                chatViewModel.configureSocket(user: authManager.user) {
                    for room in chatroomViewModel.chatRooms {
                        chatViewModel.join(room.id)
                    }
                }
            }
        }
    }
    func GroupRoomView(_ room: ChatRoom) -> some View {
        HStack (alignment: .top) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(.gray)
            VStack (alignment: .leading, spacing: 5) {
                HStack {
                    Text(room.name)
                        .font(Font.semibold20)
                        .foregroundStyle(.black)
                    Text("\(room.maxUserCount)")
                        .font(Font.regular12)
                        .foregroundStyle(.gray)
                    Text(formatTime: room.joinAt)
                        .font(Font.regular12)
                        .foregroundStyle(.gray)
                    Spacer()
                }
                Text(room.owner.nickname)
                    .foregroundStyle(.gray)
                    .font(Font.regular14)
            }
        }
    }
}

#Preview {
    GroupChatListView()
}

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
    @State private var groupRooms: [GroupChatRoom] = GroupChatRoom.dummyData
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading, spacing: 15) {
                ForEach(groupRooms, id: \.id) { room in
                    NavigationLink {
                        Text(
                            ""
                        )
                    } label: {
                        GroupRoomView(room)
                    }
                    Rectangle()
                        .fill(.gray)
                        .frame(height: 1)
                }
            }
            .padding(.horizontal, 16)
        }
    }
    func GroupRoomView(_ room: GroupChatRoom) -> some View {
        HStack (alignment: .top) {
            room.roomImage
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(.black)
            VStack (alignment: .leading, spacing: 5) {
                HStack {
                    Text(room.roomTitle)
                        .font(Font.semibold20)
                        .foregroundStyle(.black)
                    Text("\(room.roomMember)")
                        .font(Font.regular12)
                        .foregroundStyle(.gray)
                    Spacer()
                    Text(room.decodedDateToString)
                        .font(Font.regular12)
                        .foregroundStyle(.gray)
                }
                Text(room.roomLastMessage)
                    .foregroundStyle(.gray)
                    .font(Font.regular14)
            }
        }
    }
}

#Preview {
    GroupChatListView()
}

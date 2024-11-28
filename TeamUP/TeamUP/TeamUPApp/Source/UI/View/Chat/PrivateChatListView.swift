//
//  PrivateChatListView.swift
//  TeamUP
//
//  Created by Hwang_Inyoung on 11/18/24.
//


import SwiftUI

struct PrivateChatRoom: Identifiable {
    let id = UUID()
    let roomImage: Image
    let roomTitle: String
    let roomLastMessage: String
    let roomLastupdate: Date
    
    var decodedDateToString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        return formatter.string(from: roomLastupdate)
    }
    
    static let dummyData: [PrivateChatRoom] = [
        PrivateChatRoom(roomImage: Image(systemName: "person.crop.circle"), roomTitle: "알고리즘 스터디", roomLastMessage: "오늘 하루는 쉽싣다..", roomLastupdate: .now),
        PrivateChatRoom(roomImage: Image(systemName: "person.crop.circle"), roomTitle: "TeamUP", roomLastMessage: "이렇게 했는데 어떤가요?", roomLastupdate: .now),
        PrivateChatRoom(roomImage: Image(systemName: "person.crop.circle"), roomTitle: "TeamUP", roomLastMessage: "오늘 하루는 쉽싣다..", roomLastupdate: .now),
        PrivateChatRoom(roomImage: Image(systemName: "person.crop.circle"), roomTitle: "TeamUP", roomLastMessage: "이렇게 했는데 어떤가요?", roomLastupdate: .now),
        PrivateChatRoom(roomImage: Image(systemName: "person.crop.circle"), roomTitle: "TeamUP", roomLastMessage: "오늘 하루는 쉽싣다..", roomLastupdate: .now),
        PrivateChatRoom(roomImage: Image(systemName: "person.crop.circle"), roomTitle: "TeamUP", roomLastMessage: "이렇게 했는데 어떤가요?", roomLastupdate: .now)
    ]
}
struct PrivateChatListView: View {
    @State private var privateRooms: [PrivateChatRoom] = PrivateChatRoom.dummyData
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading, spacing: 15) {
                ForEach(privateRooms, id: \.id) { room in
                    NavigationLink {
                        PrivateChatView(roomTitle: "봄날은 간다")
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        PrivateRoomView(room)
                    }
                    Rectangle()
                        .fill(.gray)
                        .frame(height: 0.3)
                }
            }
            .padding(.horizontal, 16)
        }
    }
    func PrivateRoomView(_ room: PrivateChatRoom) -> some View {
        HStack (alignment: .top) {
            room.roomImage
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(.gray)
            VStack (alignment: .leading, spacing: 5) {
                HStack {
                    Text(room.roomTitle)
                        .font(Font.semibold20)
                        .foregroundStyle(.black)
//                    Text("\(room.roomMember)")
//                        .font(Font.regular12)
//                        .foregroundStyle(.gray)
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

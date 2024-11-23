//
//  ChatViewModel.swift
//  TeamUP
//
//  Created by Soom on 11/22/24.
//

import SwiftUI
import SocketIO
import Observation
import KeychainSwift

struct ChatMessage: Equatable {
    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        true
    }
    
    let user: User
    let room: Int
    let message: String
    let date: String
    
    var decodedDateString: String {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        if let date = isoDateFormatter.date(from: date) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            let timeString = timeFormatter.string(from: date)
            
            return timeString
        } else {
            return "fail"
        }
    }
}

@Observable
class ChatViewModel {
    var chatMessage: [ChatMessage] = []
    let chatUrl: String = "https://protectmeios.xyz:446"
    let namespace = "/chat"
    private let manager: SocketManager
    private let socket: SocketIOClient
    var token: String {
        if let token = KeychainSwift().get("access_token") {
            return token
        }
        return "Not found Token"
    }
    
    init() {
        let token = KeychainSwift().get("access_token")!
        self.manager = SocketManager(socketURL: URL(string: chatUrl)!, config: [
            .log(true),
            .connectParams(["nickname":"soom@gmail.com", "profile_image_name": "asd"]),
            .compress,
            .forceWebsockets(true),
            .extraHeaders(["Authorization":"Bearer \(token)"])
        ])
        self.socket = manager.socket(forNamespace: namespace)
        self.connect()
    }
    
    func connect() {
        socket.on(clientEvent: .connect) { data, ask in
            self.join(1)
            print(data)
        }
        socket.on("chat") { data, ack in
            if let message = data.first as? [String: Any],
               let user = message["user"] as? [String: Any],
               let room = message["room"] as? Int,
               let msg = message["message"] as? String,
               let date = message["date"] as? String,
               let userEmail = user["id"] as? String,
               let userNickname = user["nickname"] as? String,
               let userImage = user["profile_image_name"] as? String  {
                let chatUser = User(id: "",email: userEmail, password: "", nickname: userNickname ,profileImageName: userImage)
                self.chatMessage.append(ChatMessage(user: chatUser, room: room, message: msg , date: date))
            }
        }
        socket.connect()
    }
    func join(_ roomID: Int) {
        socket.emit("join", roomID)
    }
    func sendMessage(room: Int, message: String) {
        let data: [String: Any] = ["msg": message, "room": room]
        socket.emit("chat", data)
        print("Sent message: \(message) to room: \(room)")
    }
}



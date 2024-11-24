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
    private(set) var chatMessage: [Int: [ChatMessage]] = [:]
    private let namespace = "/chat"
    private var defaultURL = URLComponents()
    private var manager: SocketManager?
    private var socket: SocketIOClient?
    private var token: String {
        if let token = KeychainSwift().get("access_token") {
            return token
        }
        return "Not found Token"
    }
    
    init() {
        if let urlString = Bundle.main.infoDictionary?["UrlString"], let url = urlString as? String {
            defaultURL.scheme = "https"
            defaultURL.host = url
            defaultURL.port = 446
        }
    }
    
    func configureSocket(user: User?, connectEvent: @escaping () -> Void) {
        if let token = KeychainSwift().get("access_token"), let authUser = user {
            self.manager = SocketManager(socketURL: defaultURL.url!, config: [
                .log(true),
                .connectParams(["nickname": authUser.nickname, "profile_image_name": authUser.profileImageName]),
                .compress,
                .forceWebsockets(true),
                .extraHeaders(["Authorization":"Bearer \(token)"])
            ])
            self.socket = manager?.socket(forNamespace: namespace)
            self.connect(connectEvent: connectEvent)
        }
    }
    
    func connect(connectEvent: @escaping () -> Void) {
        socket?.on(clientEvent: .connect) { data, ask in
            connectEvent()
            print(data)
        }
        socket?.on("chat") { data, ack in
            if let message = data.first as? [String: Any],
               let user = message["user"] as? [String: Any],
               let room = message["room"] as? Int,
               let msg = message["message"] as? String,
               let date = message["date"] as? String,
               let userEmail = user["email"] as? String,
               let userNickname = user["nickname"] as? String,
               let userImage = user["profile_image_name"] as? String  {
                let chatUser = User(id: "",email: userEmail, password: "", nickname: userNickname ,profileImageName: userImage)
                self.chatMessage[room]!.append(ChatMessage(user: chatUser, room: room, message: msg , date: date))
                print("chat message: \(self.chatMessage)")
            } else {
                print("Chat message decode error \(data)")
            }
        }
        socket?.connect()
    }
    
    func join(_ roomID: Int) {
        socket?.emit("join", roomID)
        if chatMessage[roomID] == nil {
            chatMessage[roomID] = []
        }
    }
    
    func sendMessage(room: Int, message: String) {
        let data: [String: Any] = ["msg": message, "room": room]
        socket?.emit("chat", data)
        print("Sent message: \(message) to room: \(room)")
    }
}



//
//  ChatRoomViewModel.swift
//  TeamUP
//
//  Created by Jaemin Hong on 11/25/24.
// 

import Foundation
import KeychainSwift
import Alamofire

struct ChatRoom: Codable {
    let id: Int
    let owner: User
    var name: String
    var maxUserCount: Int
    var lastReadChatID: Int?
    let joinAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case owner
        case name
        case maxUserCount = "max_user_count"
        case lastReadChatID = "last_read_chat_id"
        case joinAt = "join_at"
    }
}

@Observable
final class ChatRoomViewModel {
    private var defaultURL = URLComponents()
    private let keychain = KeychainSwift()
    private(set) var chatRooms: [ChatRoom] = []
    
    init() {
        if let urlString = Bundle.main.infoDictionary?["UrlString"], let url = urlString as? String {
            defaultURL.scheme = "https"
            defaultURL.host = url
        }
    }
    
    func fetchChatRooms() throws {
        defaultURL.path = "/chatroom"
        
        guard let url = defaultURL.url else { throw HttpError.urlError }
        guard let key = keychain.get("access_token") else { throw HttpError.keyError }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(key)"
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: [ChatRoom].self) { [weak self] response in
                switch response.result {
                case .success(let value):
                    self?.chatRooms = value
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func addUser(postID: Int, userEmail: String) throws {
        defaultURL.path = "/chatroom/add-user"
        
        guard let url = defaultURL.url else { throw HttpError.urlError }
        guard let key = keychain.get("access_token") else { throw HttpError.keyError }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(key)"
        ]
        
        let parameters: Parameters = [
            "post_id": postID,
            "user_email": userEmail
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                    case .success:
                    print("Successfully added user to chatroom")
                case .failure(let error):
                    print(error)
                    print("Failed to add user to chatroom")
                }
            }
    }
}

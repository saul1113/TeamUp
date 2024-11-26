//
//  PostStoreView.swift
//  TeamUP
//
//  Created by Jaemin Hong on 11/21/24.
// 

import Foundation
import Alamofire
import KeychainSwift

enum HttpError: Error {
    case urlError
    case keyError
}

struct PostModelStruct: Listable, Codable {
    let id: Int
    var categoryString: String
    var user: User
    var save: Int
    var seen: Int
    var title: String
    var content: String
    var isRecruit: Bool
    var maxUserCount: Int
    var currentUserCount: Int
    var time: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryString = "category"
        case user = "owner"
        case title
        case content
        case isRecruit = "is_recruit"
        case save = "save_count"
        case seen = "watch_count"
        case maxUserCount = "max_user_count"
        case currentUserCount = "current_user_count"
        case time = "create_at"
    }
    
    init(category: String, title: String, content: String, maxUserCount: Int) {
        self.id = 0
        self.categoryString = category
        self.user = User(id: "", email: "", password: "", nickname: "", profileImageName: "")
        self.title = title
        self.content = content
        self.isRecruit = true
        self.save = 0
        self.seen = 0
        self.maxUserCount = maxUserCount
        self.currentUserCount = 0
        self.time = ""
    }
}

@Observable
final class PostViewModel {
    private let keychain = KeychainSwift()
    private var defaultURL: URLComponents = URLComponents()
    private let accessTokenKey = "access_token"
    private(set) var posts: [PostModelStruct] = []
    
    init() {
        if let urlString = Bundle.main.infoDictionary?["UrlString"], let url = urlString as? String {
            defaultURL.scheme = "https"
            defaultURL.host = url
        }
    }
    
    func setData(posts: [PostModelStruct]) {
        self.posts = posts
    }
    
    func fetchPosts(completion: @escaping (Result<[PostModelStruct], Error>) -> Void) async throws {
        defaultURL.path = "/post/all/data"
        defaultURL.queryItems = [ URLQueryItem(name: "last-date", value: "0") ]
        
        guard let url = defaultURL.url else { throw HttpError.urlError }
        guard let key = keychain.get(accessTokenKey) else { throw HttpError.keyError }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(key)"
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: [PostModelStruct].self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func addPost(_ post: PostModelStruct) async throws {
        defaultURL.path = "/post"
        
        guard let url = defaultURL.url else { throw HttpError.urlError }
        guard let key = keychain.get(accessTokenKey) else { throw HttpError.keyError }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(key)"
        ]
        
        let parameters: [String: Any] = [
            "category_name": post.categoryString,
            "title": post.title,
            "content": post.content,
            "max_user_count": post.maxUserCount
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .response { response in
                switch response.result {
                case .success(_):
                    print("success")
                case .failure(let error):
                    print("\(error.localizedDescription)")
                }
            }
    }
}

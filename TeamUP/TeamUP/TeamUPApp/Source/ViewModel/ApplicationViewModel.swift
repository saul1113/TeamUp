//
//  ApplicationViewModel.swift
//  TeamUP
//
//  Created by Jaemin Hong on 11/21/24.
// 

import Foundation
import Alamofire
import KeychainSwift

final class ApplicationViewModel {
    private let keychain = KeychainSwift()
    private var defaultURL: URLComponents = URLComponents()
    private let accessTokenKey = "access_token"
    
    init() {
        if let urlString = Bundle.main.infoDictionary?["UrlString"], let url = urlString as? String {
            defaultURL.scheme = "https"
            defaultURL.host = url
        }
    }
    
    func apply(postID: String) async throws {
        defaultURL.path = "/application-record/data"
        defaultURL.queryItems = [ URLQueryItem(name: "post-id", value: postID) ]
        
        guard let url = defaultURL.url else { throw HttpError.urlError }
        guard let key = keychain.get(accessTokenKey) else { throw HttpError.keyError }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(key)"
        ]
        
        AF.request(url, method: .post, headers: headers)
            .validate()
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

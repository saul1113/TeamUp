//
//  SignUPViewModel.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import Foundation
import Alamofire

final class SignUPViewModel: ObservableObject {
    @Published private(set) var user: User? = nil
    @Published private(set) var isValied: Bool = false
    
    private var defaultURL: URLComponents = URLComponents()
    
    init() {
        if let urlString = Bundle.main.infoDictionary?["UrlString"],
           let urlS = urlString as? String {
            defaultURL.scheme = "https"
            defaultURL.host = urlS
        }
    }
    
    // MARK: - 이메일 중복
    func checkEmail(email: String) async {
        var url = defaultURL
        url.path = "/check-exist/emnail/data"
        url.queryItems = [URLQueryItem(name: "email", value: email)]
        
        guard let requestURL = url.url else {
            return
        }
        
        do {
            AF.request(requestURL, method: .get).responseDecodable(of: [String:Bool].self) { response in
                switch response.result {
                case .success(let data):
                    if let data = data["exist"] {
                        self.isValied = data
                    }
                case .failure(let error):
                    print("Email check error: \(error.localizedDescription)" )
                }
            }
        }
    }
    // MARK: - 닉네임 중복
    func checkNicknameAvilablity(nickname: String) async {
        var url = defaultURL
        url.path = "/check-exists/nickname/data"
        url.queryItems = [URLQueryItem(name: "nickname", value: nickname)]
        
        guard let requestURL = url.url else {
            return
        }
        
        do {
            AF.request(requestURL, method: .get).responseDecodable(of: [String:Bool].self) { response in
                switch response.result {
                case .success(let data):
                    if let data = data["exist"] {
                        self.isValied = data
                    }
                case .failure(let error):
                    print("Nickname check error: \(error.localizedDescription)")
                }
            }
        }
    }
    // MARK: - 회원가입
    func signUp(user: User, password: String) async throws {
        defaultURL.path = "/user/signup"
        guard let url = defaultURL.url else {
            return
        }
        
        let parameters: [String: Any] = [
            "id": user.id,
            "email": user.email,
            "password": user.password,
            "nickname": user.nickname,
            "profile_image_name": user.profileImageName
        ]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//
//  UserModel.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import Foundation


struct User: Codable {
    let id: String
    let email: String
    var password: String
    var nickname: String
    var profileImageName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case password
        case nickname
        case profileImageName = "profile_image_name"
    }
    
    // 커스텀 디코딩 구현
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // id가 Int로 오거나 String으로 올 경우를 처리
        if let intId = try? container.decode(Int.self, forKey: .id) {
            id = String(intId) // Int를 String으로 변환
        } else {
            id = try container.decode(String.self, forKey: .id)
        }
        
        email = try container.decode(String.self, forKey: .email)
        password = (try? container.decode(String.self, forKey: .password)) ?? ""
        nickname = try container.decode(String.self, forKey: .nickname)
        profileImageName = try container.decode(String.self, forKey: .profileImageName)
    }
    
    // 기본 생성자
    init(id: String, email: String, password: String, nickname: String, profileImageName: String) {
        self.id = id
        self.email = email
        self.password = password
        self.nickname = nickname
        self.profileImageName = profileImageName
    }
}

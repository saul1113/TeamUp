//
//  UserModel.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import Foundation


struct User: Codable {
    let id: String?
    let email: String
    var password: String?
    var nickname: String
    var profileImageName: String
    var bio: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case password
        case nickname
        case profileImageName = "profile_image_name"
        case bio
    }
    
    // 커스텀 디코딩 구현
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        email = try container.decode(String.self, forKey: .email)
        password = try container.decodeIfPresent(String.self, forKey: .password) ?? ""
        nickname = try container.decode(String.self, forKey: .nickname)
        profileImageName = try container.decode(String.self, forKey: .profileImageName)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
    }
    
    //기본 생성자
    init(id: String, email: String, password: String, nickname: String, profileImageName: String, bio: String = "") {
        self.id = id
        self.email = email
        self.password = password
        self.nickname = nickname
        self.profileImageName = profileImageName
        self.bio = bio
    }
}

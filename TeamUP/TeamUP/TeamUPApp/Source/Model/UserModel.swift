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
}

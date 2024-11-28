//
//  PostModel.swift
//  TeamUP
//
//  Created by wonhoKim on 11/18/24.
//

import Foundation



enum PostCategory: String, CaseIterable, Identifiable {
    case study = "스터디"
    case project = "프로젝트"

    var id: String { self.rawValue }
}
// Post 모델
struct Post: Listable, Identifiable {
    var id: Int
    var category: PostCategory
    var user: User
    var isRecruit: Bool
    var title: String
    var content: String
    var time: String
    var save: Int
    var seen: Int
    var maxCapacity: Int
    var currentCapacity: Int
    var hasTag: [String]
    
    
    var categoryString: String {
        return category.rawValue
    }
}

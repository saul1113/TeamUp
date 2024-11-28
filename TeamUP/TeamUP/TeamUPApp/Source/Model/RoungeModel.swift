//
//  RoungeModel.swift
//  TeamUP
//
//  Created by wonhoKim on 11/18/24.
//
import Foundation

protocol Listable {
    var categoryString: String { get }
    var user: User { get }
    var title: String { get }
    var content: String { get }
    var time: String { get }
    var save: Int { get }
    var seen: Int { get }
    var id : Int {get}
}


enum RoungeCategory: String, CaseIterable, Identifiable {
    case qna = "Q&A"
    case talk = "잡담"
    
    var id: String { self.rawValue }
}

// Rounge 모델
struct Rounge: Listable, Identifiable {
    var id: Int
    var category: RoungeCategory
    var user: User
    var title: String
    var content: String
    var reply: [Reply]
    var time: String
    var save: Int
    var seen: Int
    var hasTag: [String]
    
    var categoryString: String {
        return category.rawValue
    }
}
struct Reply: Identifiable, Codable {
    var id: String = UUID().uuidString // 댓글 고유 ID
    var user: String // 작성자
    var content: String // 댓글 내용
    var timestamp: Date // 작성 시간
}

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
    var hasTag: [String] {get}
}


enum RoungeCategory: String, CaseIterable, Identifiable {
    case qna = "Q&A"
    case talk = "잡담"
    
    var id: String { self.rawValue }
}

// Rounge 모델
struct Rounge: Listable {
    var category: RoungeCategory
    var user: User
    var title: String
    var content: String
    var reply: [String]
    var time: String
    var save: Int
    var seen: Int
    var hasTag: [String]
    
    var categoryString: String {
        return category.rawValue
    }
}

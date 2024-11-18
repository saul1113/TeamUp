//
//  RoungeModel.swift
//  TeamUP
//
//  Created by wonhoKim on 11/18/24.
//

enum RoungeCategory: String, CaseIterable, Identifiable {
    case qna = "Q&A"
    case talk = "잡담"
    
    var id: String { self.rawValue }
}




struct Rounge {
    var category: RoungeCategory
    var user: String
    var title: String
    var content: String
    var reply: [String]
    var time: String
    var save: Int
    var seen: Int
}

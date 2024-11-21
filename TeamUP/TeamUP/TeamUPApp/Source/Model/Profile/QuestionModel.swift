//
//  QuestionModel.swift
//  TeamUP
//
//  Created by 강희창 on 11/21/24.
//

import Foundation

struct QuestionModel: Identifiable {
    let id: UUID = UUID()
    var title: String
    var content: String
    var createAt: String
    var answers: [AnswerModel]
}

struct AnswerModel: Identifiable {
    let id: UUID = UUID()
    var content: String
    var createAt: String
}

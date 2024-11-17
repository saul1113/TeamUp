//
//  QuestionView.swift
//  TeamUP
//
//  Created by Jaemin Hong on 11/17/24.
// 

import SwiftUI

struct QuestionView: View {
    private let content: [InformationDetailView] = [
        InformationDetailView(item: InformationModel(title: "질문 1", content: "무슨 질문이 하고싶었나요?", createAt: "2024.11.17")),
        InformationDetailView(item: InformationModel(title: "질문 2", content: "질문이란 무엇인가", createAt: "2024.11.17")),
        InformationDetailView(item: InformationModel(title: "질문 3", content: "질문은 사람이다", createAt: "2024.11.17"))
    ]
    
    var body: some View {
        InformationView(title: "자주 묻는 질문", contents: content)
    }
}

#Preview {
    NavigationStack {
        QuestionView()
    }
}

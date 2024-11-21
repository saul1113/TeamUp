//
//  QuestionView.swift
//  TeamUP
//
//  Created by Jaemin Hong on 11/17/24.
//

import SwiftUI

struct QuestionView: View {
    @StateObject private var viewModel = QuestionViewModel()
    private let padding: CGFloat = 20
    
    var body: some View {
        NavigationStack {
            List(viewModel.questions) { question in
                NavigationLink(destination: QuestionDetailView(question: question, viewModel: viewModel)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(question.title)
                            .font(.bold20)
                        Text(question.createAt)
                            .font(.semibold18)
                            .foregroundStyle(.gray)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("자주 묻는 질문")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem (placement: .topBarLeading) {
                    BackButtonBlack()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        QuestionView()
    }
}

//
//  QuestionDetailView.swift
//  TeamUP
//
//  Created by 강희창 on 11/21/24.
//

import SwiftUI

struct QuestionDetailView: View {
    private let padding: CGFloat = 20
    let question: QuestionModel
    @ObservedObject var viewModel: QuestionViewModel
    @State private var newAnswerContent: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(question.title)
                .font(.bold20)
            
            Text(question.content)
                .font(.body)
            Text("작성일: \(question.createAt)")
                .font(.semibold16)
                .foregroundColor(.gray)
            
            Divider()
            
            // 답변 목록
            Text("답변")
                .font(.semibold20)
            if question.answers.isEmpty {
                Text("아직 답변이 없습니다.")
                    .font(.semibold20)
                    .foregroundColor(.gray)
            } else {
                ForEach(question.answers) { answer in
                    VStack(alignment: .leading, spacing: 5) {
                        Text(answer.content)
                            .font(.regular16)
                        Text(answer.createAt)
                            .font(.regular12)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .padding(.horizontal, padding)
//        .navigationTitle(question.title).font(.bold18)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem (placement: .topBarLeading) {
                BackButtonBlack()
            }
        }
    }
}

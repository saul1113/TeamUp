//
//  QuestionViewModel.swift
//  TeamUP
//
//  Created by 강희창 on 11/21/24.
//

import Combine
import Foundation

class QuestionViewModel: ObservableObject {
    @Published var questions: [QuestionModel] = []
    
    init() {
        fetchQuestions()
    }
    
    func fetchQuestions() {
        // 더미 데이터 초기화
        questions = [
            QuestionModel(
                title: "Q. 원하는 프로젝트 팀을 어떻게 구할 수 있나요?",
                content: "팀을 구하고싶은데, 어떻게 신청하고 팀을 만들 수 있나요?",
                createAt: "2024.11.17",
                answers: [AnswerModel(content: "A. 내가 직접 만들기하여 원하는 프로젝트와 기간, 인원을 정하고 모집 하실 수도 있고, 모집중인 프로젝트를 보고 자신이 원하는 기술스택과 프로젝트들을 살펴보고 신청하실 수 있습니다.", createAt: "2024.11.18")]
            ),
            QuestionModel(
                title: "Q. 신청한 프로젝트원을 거절하면 상대에게 어떻게 거절되나요?",
                content: "제가 원하는 팀원이 아니여서 신청된 팀원을 거절하게 되면 거절받은 상대가 어떻게 보여지는지 궁금합니다.",
                createAt: "2024.11.17",
                answers: [AnswerModel(content: "A. 신청한 팀원이 거절받게 되면, 따로 거절메시지가 가는 것은 아니고, 신청했던 프로젝트 명단에서 지워지게 됩니다.", createAt: "2024.11.18")]
            ),
            QuestionModel(
                title: "Q. 닉네임 수정이 가능한가요?",
                content: "닉네임을 첫 가입 설정 때 오타가 있어서 변경하고 싶은데 가능한가요?",
                createAt: "2024.11.17",
                answers: [AnswerModel(content: "A. 가능합니다. 하단의 프로필 탭에서 프로필 수정으로 들어가셔서 수정하시면 됩니다.", createAt: "2024.11.21")]
            )
        ]
    }
    
    func addAnswer(to question: QuestionModel, answerContent: String) {
        // 답변 추가 로직
        if let index = questions.firstIndex(where: { $0.id == question.id }) {
            let newAnswer = AnswerModel(content: answerContent, createAt: Date().formatted(date: .numeric, time: .shortened))
            questions[index].answers.append(newAnswer)
        }
    }
}

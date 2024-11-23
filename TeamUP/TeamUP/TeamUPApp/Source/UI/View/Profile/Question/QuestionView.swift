//
//  QuestionView.swift
//  TeamUP
//
//  Created by Jaemin Hong on 11/17/24.
//


import SwiftUI

struct QuestionView: View {
    @State private var expandedQuestion: Int? = nil  // 확장된 질문의 인덱스
    
    // 자주 묻는 질문 데이터
    let faqs = [
        ("Q. 앱 사용이 무료인가요? 유료 기능이 있나요?", "A. 현재 저희 'TeamUp'은 무료로 진행하고 있습니다."),
        ("Q. 부적절한 모집 글이나 사용자 신고는 어떻게 하나요?", "A. 현재는 신고기능이 없지만, 팀 전체에 해를 끼칠 수 있는 상황, 모집 글과는 다른 목적의 부적절한 모임을 진행하는 등의 불상사를 예방하기 위해, 신고 기능과 모집자, 참여자 모두에게 후기 및 온도를 남길 수 있는 기능을 준비 중에 있습니다."),
        ("Q. 원하는 프로젝트 팀을 어떻게 구할 수 있나요?", "A. 내가 직접 만들기하여 원하는 프로젝트와 기간, 인원을 정하고 모집 하실 수도 있고, 모집중인 프로젝트를 보고 자신이 원하는 기술스택과 프로젝트들을 살펴보고 신청하실 수 있습니다."),
        ("Q. 신청한 프로젝트원을 거절하면 상대에게 어떻게 거절되나요?", "A. 신청한 팀원이 거절받게 되면, 따로 거절메시지가 가는 것은 아니고, 신청했던 프로젝트 명단에서 지워지게 됩니다."),
        ("Q. 닉네임 수정이 가능한가요?", "A. 현재로는 프로젝트를 피해주며 닉네임을 바꾸는 사례를 방지하기 위해, 불가능하게 되어있습니다. 추후에 변경 가능한 방향성으로 고려 중에 있습니다."),
        ("Q. 프로젝트 신청을 취소할 수 있나요?","A. 현재는 신청자가 취소할 수 없지만, 채팅으로 인하여 모집자에게 취소 요청을 할 수 있습니다. 빠른 시일내에 해당 기능에 대해 준비하도록 하겠습니다."),
        
        ("Q. 신청이 수락되면 알림이 오나요?", "A. 현재 모든 알림서비스를 제공하지 않고 있습니다. 모집자 신청자 모든 사용자들에게 편의를 위해 조만간 업데이트 될 예정입니다."),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(Array(faqs.enumerated()), id: \.offset) { index, faq in
                    VStack {
                        Divider()
                        HStack {
                            Text(faq.0)
                                .font(.semibold20)
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: expandedQuestion == index ? "chevron.up" : "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .contentShape(Rectangle())  // 탭 가능하도록 설정
                        .onTapGesture {
                            withAnimation {
                                if expandedQuestion == index {
                                    expandedQuestion = nil  // 이미 선택된 질문이면 닫기
                                } else {
                                    expandedQuestion = index  // 선택된 질문 열기
                                }
                            }
                        }
                        if expandedQuestion == index {
                            Divider()
                            Text(faq.1)
                                .font(.regular16)
                                .padding(.top, 5)
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                    .background(Color.white) 
                    .cornerRadius(4)
                    .padding(.horizontal, 20)
                }
            }
        }
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


#Preview {
    NavigationStack {
        QuestionView()
    }
}

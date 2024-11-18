//
//  PostModel.swift
//  TeamUP
//
//  Created by wonhoKim on 11/18/24.
//


enum MainPostCategory: String, CaseIterable, Identifiable {
    case study = "스터디"
    case project = "프로젝트"
    
    case qna = "Q&A"
    case talk = "잡담"
    
    
    var id: String { self.rawValue }
}



// 게시글 데이터 구조체
struct Post {
    var category: MainPostCategory //공통
    var user: String //공통
    var isRecruit: Bool //스터디, 프로젝트
    var title: String // 공통
    var content: String// 공통
    var reply: String //qna, 잡담
    var time: String// 공통
    var save: Int // 공통
    var seen: Int //공통
    //총인원수
    var capacity: Int // 스터디, 프로젝트
    
  
    
}

//
//  AnnouncementViewModel.swift
//  TeamUP
//
//  Created by 강희창 on 11/21/24.
//

import Combine

final class AnnouncementViewModel: ObservableObject {
    @Published var announcementList: [InformationModel] = []
    
    init() {
        fetchInformationData()
    }
    
    private func fetchInformationData() {
            
        announcementList = [
            InformationModel(title: "[공지] 첫 번째 공지", content: "첫 번째 공지 내용입니다.", createAt: "2024.11.17"),
            InformationModel(title: "[공지] 두 번째 공지", content: "두 번째 공지 내용입니다.", createAt: "2024.11.18")
            ]
        }
}

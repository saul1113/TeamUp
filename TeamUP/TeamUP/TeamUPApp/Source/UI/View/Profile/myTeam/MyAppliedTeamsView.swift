//
//  MyAppliedTeamsView.swift
//  TeamUP
//
//  Created by Hwang_Inyoung on 11/21/24.
//

import SwiftUI

struct MyAppliedTeamsView: View {
    @State private var selectedTab = 0
    @State private var searchText = ""
    
    // Mock 데이터
    let appliedTeams: [Post] = [
        Post(
            category: .study,
            user: User(id: "1", email: "test@test.com", password: "123", nickname: "수민이다", profileImageName: "default.png"),
            isRecruit: true,
            title: "알고리즘 스터디",
            content: "초보 환영하고 간혹 친목도 해요 연락주세요!",
            time: "2024년 11월 18일",
            save: 12,
            seen: 13,
            maxCapacity: 5,
            currentCapacity: 2,
            hasTag: ["스터디"]
        )
    ]
    
    var body: some View {
        VStack {
            // 탭 전환
            Picker("Tabs", selection: $selectedTab) {
                Text("전체").tag(0)
                Text("신청대기").tag(1)
                Text("신청완료").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            Divider()
            
            // 리스트
            List {
                ForEach(appliedTeams.filter {
                    searchText.isEmpty || $0.title.contains(searchText)
                }) { team in
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text(team.categoryString)
                                    .font(.semibold14)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.customBlue)
                                    .cornerRadius(4)
                                
                                Spacer()
                                
                                Text("신청대기")
                                    .font(.semibold12)
                                    .foregroundColor(.gray)
                            }
                            Text(team.title)
                                .font(.semibold16)
                                .foregroundColor(.black)
                            
                            Text(team.content)
                                .font(.regular14)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                            
                            HStack {
                                Text(team.user.nickname)
                                Text("·")
                                Text(team.time)
                                
                                Spacer()
                                
                                HStack {
                                    Image(systemName: "person")
                                    Text("\(team.currentCapacity)/\(team.maxCapacity)")
                                }
                                .font(.regular14)
                                .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            .listStyle(.plain)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonBlack()
            }
            
            ToolbarItem(placement: .principal) {
                Text("내가 신청한 팀")
                    .font(.semibold20)
                    .foregroundColor(.black)
            }
        }
    }
}

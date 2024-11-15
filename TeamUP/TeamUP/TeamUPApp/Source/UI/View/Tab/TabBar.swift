//
//  Tab.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: MainTabView.Tab
    var body: some View {
        VStack(spacing: 0){
            Divider()
            HStack (spacing: 0){
                Button(action: {
                    selectedTab = .home
                }) {
                    VStack(alignment: .center,spacing: 0){
                        Image(systemName: "house")
                            .frame(width: 30,height: 30)
                            .foregroundColor(selectedTab == .home ? .accentColor : Color.projectTab)
                        Text("홈")
                            .foregroundColor(selectedTab == .home ? .accentColor : Color.projectTab)
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                }
                Button{
                    selectedTab = .lounge
                }label: {
                    VStack(alignment: .center,spacing: 0){
                        Image(systemName: "chair.lounge")
                            .frame(width: 30,height: 30)
                            .foregroundColor(selectedTab == .lounge ? .accentColor : Color.projectTab)
                        Text("라운지")
                            .foregroundColor(selectedTab == .lounge ?  .accentColor : Color.projectTab)
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                }
                Button{
                    selectedTab = .post
                }label: {
                    VStack(alignment: .center,spacing: 0){
                        Image(systemName: "plus")
                            .frame(width: 30,height: 30)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(selectedTab == .post  ? .accentColor : Color.projectTab)
                        Text("플러스")
                            .foregroundStyle(selectedTab == .post  ? .accentColor : Color.projectTab)
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                }
                Button{
                    selectedTab = .chat
                }label: {
                    VStack(alignment: .center,spacing: 0){
                        Image(systemName: "message")
                            .frame(width: 30,height: 30)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(selectedTab == .chat  ? .accentColor : Color.projectTab)
                        Text("채팅")
                            .foregroundStyle(selectedTab == .chat  ? .accentColor : Color.projectTab)
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                }
                Button{
                    selectedTab = .profile
                }label: {
                    VStack(alignment: .center,spacing: 0){
                        Image(systemName: "person.fill")
                            .frame(width: 30,height: 30)
                        Text("프로필")
                    }
                    .foregroundColor(selectedTab == .profile ? .accentColor : Color.projectTab)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
    }
}

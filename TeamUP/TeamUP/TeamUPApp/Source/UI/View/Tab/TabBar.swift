//
//  Tab.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: MainTabView.Tab
    @Binding var isPostPresented: Bool
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
                            .foregroundColor(selectedTab == .home ? .customBlue : Color.projectTab)
                        Text("모집")
                            .foregroundColor(selectedTab == .home ? .customBlue : Color.projectTab)
                            .font(.semibold16)
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
                            .foregroundColor(selectedTab == .lounge ? .customBlue : Color.projectTab)
                        Text("라운지")
                            .foregroundColor(selectedTab == .lounge ?  .customBlue : Color.projectTab)
                            .font(.semibold16)
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                }
                Button{
                    isPostPresented = true 
                }label: {
                    VStack(alignment: .center,spacing: 0){
                        Image(systemName: "plus")
                            .frame(width: 50,height: 50)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(selectedTab == .post  ? .customBlue : Color.projectTab)
                        Text("")
                            .foregroundStyle(selectedTab == .post  ? .customBlue : Color.projectTab)
                            .font(.semibold16)
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
                            .foregroundStyle(selectedTab == .chat  ? .customBlue : Color.projectTab)
                        Text("채팅")
                            .foregroundStyle(selectedTab == .chat  ? .customBlue : Color.projectTab)
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
                            .font(.semibold16)
                    }
                    .foregroundColor(selectedTab == .profile ? .customBlue : Color.projectTab)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
    }
}

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
                    VStack(alignment: .center, spacing: 0){
                        Spacer()
                            .frame(height: 10)
                        Image(systemName: "house")
                            .resizable()
                            .foregroundStyle(selectedTab == .home  ? .customBlue : .customTab)
                            .frame(width: 20, height: 20)
                            .scaledToFit()
                        
                        Spacer()
                            .frame(height: 4)
                        Text("모집")
                            .foregroundColor(selectedTab == .home ? .customBlue : .customTab)
                            .font(.semibold14)
                        
                        Spacer()
                            .frame(height: 4)
                        RoundedRectangle(cornerRadius: 26)
                            .fill(selectedTab == .home ? .customBlue : Color.clear)
                            .frame(height: 4)
                            .padding(.horizontal, 2)
                        
                    }
                    .frame(maxWidth: .infinity)
                }
                Button{
                    selectedTab = .lounge
                }label: {
                    VStack(alignment: .center,spacing: 0){
                        
                        Spacer()
                            .frame(height: 10)
                        
                        Image(systemName: "chair.lounge")
                            .resizable()
                            .foregroundStyle(selectedTab == .lounge  ? .customBlue : .customTab)
                            .frame(width: 20, height: 20)
                            .scaledToFit()
                        Spacer()
                            .frame(height: 4)
                        Text("라운지")
                            .foregroundColor(selectedTab == .lounge ?  .customBlue : .customTab)
                            .font(.semibold14)
                        
                        Spacer()
                            .frame(height: 4)
                        
                        RoundedRectangle(cornerRadius: 26)
                            .fill(selectedTab == .lounge ?  .customBlue : Color.clear)
                            .frame(height: 4)
                        
                    }
                    .frame(maxWidth: .infinity)
                }
                Button{
                    isPostPresented = true 
                }label: {
                    VStack(alignment: .center,spacing: 4){
                        Image(.teamUpPlusIcon)
                            .resizable()
                            .frame(width: 50,height: 50)
                            .foregroundStyle(selectedTab == .post  ? .customBlue : .customTab)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                            .offset(y: -10)
                        Text("")
                            .foregroundStyle(selectedTab == .post  ? .customBlue : .customTab)
                            .font(.semibold14)
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                }
                Button{
                    selectedTab = .chat
                }label: {
                    VStack(alignment: .center,spacing: 0){
                        Spacer()
                            .frame(height: 10)
                        
                        Image(systemName: "message")
                            .resizable()
                            .foregroundStyle(selectedTab == .chat ? .customBlue : .customTab)
                            .frame(width: 20, height: 20)
                            .scaledToFit()
                        
                        Spacer()
                            .frame(height: 4)
                        
                        Text("채팅")
                            .foregroundStyle(selectedTab == .chat  ? .customBlue : .customTab)
                            .font(.semibold14)
                        
                        Spacer()
                            .frame(height: 4)
                        
                        RoundedRectangle(cornerRadius: 26)
                            .fill(selectedTab == .chat ?  .customBlue : Color.clear)
                            .frame(height: 4)
                    }
                    .frame(maxWidth: .infinity)
                }
                Button{
                    selectedTab = .profile
                }label: {
                    VStack(alignment: .center,spacing: 0){
                        Spacer()
                        Image(systemName: "person.fill")
                            .resizable()
                            .foregroundStyle(selectedTab == .profile ? .customBlue : .customTab)
                            .frame(width: 20, height: 20)
                            .scaledToFit()
                        
                        Spacer()
                            .frame(height: 4)
                        Text("프로필")
                            .font(.semibold14)
                        Spacer()
                            .frame(height: 4)
                        RoundedRectangle(cornerRadius: 26)
                            .fill(selectedTab == .profile ?  .customBlue : Color.clear)
                            .frame(height: 4)
                    }
                    .foregroundColor(selectedTab == .profile ? .customBlue : .customTab)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
    }
}
#Preview {
    TabBar(selectedTab: .constant(.home), isPostPresented: .constant(false))
}

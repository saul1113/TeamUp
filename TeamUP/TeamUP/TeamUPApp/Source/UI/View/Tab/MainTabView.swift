//
//  ContentView.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .home
    enum Tab {
        case home
        case lounge
        case post
        case chat
        case profile
    }
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom){
                VStack(alignment: .center,spacing: 0) {
                    Spacer()
                    switch selectedTab {
                    case .home:
                        HomeView()
                            .tabItem() {
                                Label("홈", systemImage: "house")
                            }
                            .tag(0)
                        
                    case .lounge:
                        LoungeView()
                            .tabItem() {
                                Label("라운지", systemImage: "list.bullet.clipboard")
                            }
                            .tag(1)
                        
                    case .post:
                        PostView()
                            .tabItem () {
                                Label("", systemImage: "pill")
                            }
                            .tag(2)
                        
                    case .chat:
                        ChatView()
                            .tabItem() {
                                Label("HealthList", systemImage: "list.clipboard")
                            }
                            .tag(3)
                    case .profile:
                        ProfileView()
                            .tabItem() {
                                Label("Profile", systemImage: "person.crop.circle")
                            }
                            .tag(4)
                    }
                }
                TabBar(selectedTab: $selectedTab)
                    .frame(alignment: .bottom)
                    .background(.white)
            }
        }
    }
}



#Preview {
    MainTabView()
}

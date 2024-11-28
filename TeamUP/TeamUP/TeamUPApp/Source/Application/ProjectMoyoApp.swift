//
//  ProjectMoyoApp.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI

@main
struct ProjectMoyoApp: App {
    private var authManager: AuthManager = AuthManager()
    private var postViewModel: PostViewModel = PostViewModel()
    private var chatViewModel: ChatViewModel = ChatViewModel()
    private var chatroomViewModel: ChatRoomViewModel = ChatRoomViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StartTeamupView()
            }
            .environment(authManager)
            .environment(postViewModel)
            .environment(chatViewModel)
            .environment(chatroomViewModel)
        }
    }
}

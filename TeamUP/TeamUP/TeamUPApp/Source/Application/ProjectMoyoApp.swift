//
//  ProjectMoyoApp.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI

@main
struct ProjectMoyoApp: App {
    @State private var authManager: AuthManager = AuthManager()
    @State private var postViewModel: PostViewModel = PostViewModel()
    @State private var chatViewModel: ChatViewModel = ChatViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StartTeamupView()
            }
            .environment(authManager)
            .environment(postViewModel)
            .environment(chatViewModel)
        }
    }
}

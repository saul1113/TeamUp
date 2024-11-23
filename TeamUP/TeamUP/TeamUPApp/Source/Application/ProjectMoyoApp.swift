//
//  ProjectMoyoApp.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI

@main
struct ProjectMoyoApp: App {
    @StateObject private var authManager: AuthManager = AuthManager()
    @StateObject private var postViewModel: PostViewModel = PostViewModel()
    @StateObject private var applicationViewModel: ApplicationViewModel = ApplicationViewModel()
    @State private var chatViewModel: ChatViewModel = ChatViewModel()
    var body: some Scene {
        WindowGroup {
            StartTeamupView()
                .environmentObject(authManager) // 인스턴스 전달
                .environmentObject(postViewModel)
                .environmentObject(applicationViewModel)
                .environment(chatViewModel)
        }
    }
}

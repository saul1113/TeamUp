//
//  SignUpPasswordView.swift
//  TeamUP
//
//  Created by 강희창 on 11/18/24.
//

import SwiftUI

struct SignUpPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = SignUPViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SignUpPasswordView()
}

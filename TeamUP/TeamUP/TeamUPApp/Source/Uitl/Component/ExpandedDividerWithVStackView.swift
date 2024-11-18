//
//  ListWithExpandedDividerView.swift
//  TeamUP
//
//  Created by Jaemin Hong on 11/17/24.
//

import SwiftUI

struct ExpandedDividerWithVStackView<Content: View>: View {
    private let content: () -> Content
    private let padding: CGFloat
    
    init(padding: CGFloat = 20, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.padding = padding
    }
    
    var body: some View {
        VStack {
            content()
            
            Divider()
                .padding(.horizontal, -padding)
        }
    }
}

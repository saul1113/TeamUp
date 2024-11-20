//
//  CustomPadding.swift
//  TeamUP
//
//  Created by Soom on 11/18/24.
//

import SwiftUI

struct CustomPadding: ViewModifier {
    func body(content: Content) -> some View {
          content
            .padding(.horizontal, 16)
      }
}

extension View {
    func customPadding() -> some View {
        self.modifier(CustomPadding())
    }
}

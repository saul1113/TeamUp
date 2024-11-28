//
//  CustomBackButton.swift
//  TeamUP
//
//  Created by Jaemin Hong on 11/17/24.
//

import Foundation
import SwiftUI

struct CustomBackButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                }
            }
    }
}

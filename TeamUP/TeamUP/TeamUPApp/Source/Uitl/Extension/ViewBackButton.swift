//
//  ViewBackButton.swift
//  TeamUP
//
//  Created by Jaemin Hong on 11/17/24.
// 

import Foundation
import SwiftUI

extension View {
    public func backButton() -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                }
            }
    }
}

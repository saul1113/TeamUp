//
//  CustomBackButton.swift
//  TeamUP
//
//  Created by Soom on 11/18/24.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Button {
            dismiss()
        }label: {
            Image(systemName: "chevron.left")
                .resizable()
                .frame(width: 10 , height: 15)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    CustomBackButton()
}

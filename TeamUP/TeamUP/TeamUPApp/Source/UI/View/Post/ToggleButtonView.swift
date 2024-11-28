//
//  ToggleButton.swift
//  TeamUP
//
//  Created by 김수민 on 11/19/24.
//

import SwiftUI

struct ToggleButtonView: View {
    @Binding var isPreviewMode: Bool
        
        var body: some View {
            ZStack {
                Capsule()
                    .strokeBorder(Color.gray, lineWidth: 0.5)
                    .frame(width: 120, height: 40)
                
                HStack {
                    ZStack {
                        Capsule()
                            .fill(isPreviewMode ? Color.clear : Color.customBlue)
                            .frame(width: 58, height: 40)
                       
                        Text("편집")
                            .font(.semibold12)
                            .foregroundColor(isPreviewMode ? .customBlue : .white)
                    }
                    .onTapGesture {
                            isPreviewMode = false
                    }
                    
                    ZStack {
                        Capsule()
                            .fill(isPreviewMode ? Color.customBlue : Color.clear)
                            .frame(width: 58, height: 40)

                        Text("미리보기")
                            .font(.semibold12)
                            .foregroundColor(isPreviewMode ? .white : .customBlue)
                    }
                    .onTapGesture {
                            isPreviewMode = true
                    }
                }
            }
            .cornerRadius(20)
        }
}

#Preview {
    ToggleButtonView(isPreviewMode: .constant(false))
}


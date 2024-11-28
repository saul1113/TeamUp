//
//  TextFieldView.swift
//  TeamUP
//
//  Created by 강희창 on 11/16/24.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var text: String
    var placeholder: String
    var isSecure: Bool = false       // 보안 입력 여부
    var errorColor: Color = .red
    var errorMessage: String? = nil
    var onTextChange: ((String) -> Void)? // 텍스트 변경 시 호출되는 콜백
    
    @FocusState private var isFocused: Bool // 텍스트 필드의 포커스 상태를 관리하는 프로퍼티
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) { // 필드와 에러 메시지를 정렬하고 간격 설정
            ZStack {
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .cornerRadius(4)
                        .overlay {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(isFocused ? .customBlue : .gray, lineWidth: 1)
                        }
                        .focused($isFocused)             // 포커스 상태 추적
                        .onChange(of: text) { newValue in
                            onTextChange?(newValue)      // 텍스트 변경 시 콜백 호출
                        }
                } else {
                    TextField(placeholder, text: $text)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(isFocused ? .customBlue : .gray, lineWidth: 1)
                        }
                        .focused($isFocused)
                        .onChange(of: text) { newValue in
                            onTextChange?(newValue)
                        }
                }
            }
            if let errorMessage {
                Text(errorMessage)
                    .font(.regular12)
                    .foregroundColor(errorColor)
                    .padding(.top, 4)
            }
        }
    }
}

#Preview {
    TextFieldView(
        text: .constant(""),
        placeholder: "Text",
        errorMessage: "Error"
    )
}

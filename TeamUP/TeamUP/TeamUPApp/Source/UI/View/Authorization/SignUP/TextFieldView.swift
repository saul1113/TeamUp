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
    @State private var showPassword: Bool = false // 비밀번호 보이기/가리기 상태
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                if isSecure {
                    if showPassword {
                        TextField(placeholder, text: $text)
                            .autocapitalization(.none)
                            .textContentType(.password)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .cornerRadius(4)
                            .overlay {
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(isFocused ? Color(hex: "6B6B6B") : .customLightGray, lineWidth: 1)
                            }
                            .focused($isFocused)
                            .onChange(of: text) { newValue in
                                text = newValue.lowercased() // 입력된 텍스트를 소문자로 변환
                                onTextChange?(text)
                            }
                            .overlay(
                                buttonGroup, alignment: .trailing // 버튼 그룹을 오른쪽에 배치
                            )
                    } else {
                        SecureField(placeholder, text: $text)
                            .autocapitalization(.none)
                            .textContentType(.password)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .cornerRadius(4)
                            .overlay {
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(isFocused ? Color(hex: "6B6B6B") : .customLightGray, lineWidth: 1)
                            }
                            .focused($isFocused)
                            .onChange(of: text) { newValue in
                                text = newValue.lowercased()
                                onTextChange?(text)
                            }
                            .overlay(
                                buttonGroup, alignment: .trailing // 버튼 그룹을 오른쪽에 배치
                            )
                    }
                } else {
                    // 일반 텍스트 필드
                    TextField(placeholder, text: $text)
                        .autocapitalization(.none)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .cornerRadius(4)
                        .overlay {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(isFocused ? Color(hex: "6B6B6B") : .customLightGray, lineWidth: 1)
                        }
                        .focused($isFocused)
                        .onChange(of: text) { newValue in
                            text = newValue.lowercased() // 입력된 텍스트를 소문자로 변환
                            onTextChange?(text)
                        }
                        .overlay(
                            buttonGroup, alignment: .trailing // 버튼 그룹을 오른쪽에 배치
                        )
                }
            }
            ZStack {
                if let errorMessage {
                    Text(errorMessage)
                        .font(.regular14)
                        .foregroundColor(.customRed)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(height: 20) // 고정된 높이로 설정하여 레이아웃 변화 방지
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var buttonGroup: some View {
        HStack(spacing: 8) {
            if !text.isEmpty {
                Button(action: {
                    text = "" // 텍스트 초기화
                    onTextChange?(text)
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            if isSecure {
                Button(action: {
                    showPassword.toggle()
                }) {
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.trailing, 10)
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

#Preview {
    TextFieldView(
        text: .constant(""),
        placeholder: "Text",
        errorMessage: "Error"
    )
}

//
//  TextEditorView.swift
//  TeamUP
//
//  Created by 김수민 on 11/18/24.
//

import SwiftUI
import MarkdownUI

struct TextEditorView: View {
    @Binding var markdownText: String
    @State private var selectedRange: NSRange?
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Button {
                    sizeHeader(level: 1)
                } label: {
                    HStack {
                        Text("H")
                            .foregroundStyle(.black)
                            .font(.system(size: 16, weight: .regular, design: .serif))
                        Text("1")
                            .foregroundStyle(.black)
                            .font(.system(size: 10, weight: .regular, design: .serif))
                            .padding(.bottom, -7)
                            .padding(.leading, -7)
                    }
                }
                
                Button {
                    sizeHeader(level: 2)
                } label: {
                    HStack {
                        Text("H")
                            .foregroundStyle(.black)
                            .font(.system(size: 16, weight: .regular, design: .serif))
                        Text("2")
                            .foregroundStyle(.black)
                            .font(.system(size: 10, weight: .regular, design: .serif))
                            .padding(.bottom, -7)
                            .padding(.leading, -7)
                        
                    }
                }
                
                Button {
                    sizeHeader(level: 3)
                } label: {
                    HStack {
                        Text("H")
                            .foregroundStyle(.black)
                            .font(.system(size: 16, weight: .regular, design: .serif))
                        Text("3")
                            .foregroundStyle(.black)
                            .font(.system(size: 10, weight: .regular, design: .serif))
                            .padding(.bottom, -7)
                            .padding(.leading, -7)
                        
                    }
                }
                
                Divider()
                    .frame(height: 30)
                
                Button {
                    markdownStyle(left: "**", right: "**")
                } label: {
                    Image(systemName: "bold")
                        .foregroundStyle(.black)
                }
                
                Button {
                    markdownStyle(left: "_", right: "_")
                } label: {
                    Image(systemName: "italic")
                        .foregroundStyle(.black)
                }
                
                Button {
                    markdownStyle(left: "_", right: "_")
                } label: {
                    Image(systemName: "underline")
                        .foregroundStyle(.black)
                }
                
                Button {
                    markdownStyle(left: "~~", right: "~~")
                } label: {
                    Image(systemName: "strikethrough")
                        .foregroundStyle(.black)
                }
                
                Divider()
                    .frame(height: 30)

                Button {
                    insertLink()
                } label: {
                    Image(systemName: "link")
                        .foregroundStyle(.black)
                }
                
            }
            .font(.system(size: 18))
            
            Divider()
                .padding(-20)
                .padding(.top, 20)
            
            CustomMarkdownView(text: $markdownText, selectedRange: $selectedRange)
                .frame(height: 400)
            
            Spacer()
        }
        .padding()
        
        .navigationTitle("")
    }
    
    func markdownStyle(left: String, right: String) {
        guard let range = selectedRange else { return }
        
        let startIndex = markdownText.index(markdownText.startIndex, offsetBy: range.location)
        let endIndex = markdownText.index(startIndex, offsetBy: range.length)
        let selectedText = markdownText[startIndex..<endIndex]
        
        let newText = "\(left)\(selectedText)\(right)"
        markdownText.replaceSubrange(startIndex..<endIndex, with: newText)
        
        let newRange = NSRange(location: range.location, length: newText.count)
        selectedRange = newRange
    }
    
    func insertLink() {
        let linkText = "[링크 이름](URL을 입력해주세요)"
        markdownText += linkText
    }
    
    func sizeHeader(level: Int) {
        guard let range = selectedRange else { return }
        
        let header = String(repeating: "#", count: level) + " "
        
        let startIndex = markdownText.index(markdownText.startIndex, offsetBy: range.location)
        let endIndex = markdownText.index(startIndex, offsetBy: range.length)
        let selectedText = markdownText[startIndex..<endIndex]
        
        let newText = "\(header)\(selectedText)"
        markdownText.replaceSubrange(startIndex..<endIndex, with: newText)
        
        let newRange = NSRange(location: range.location, length: newText.count)
        selectedRange = newRange
    }
}




#Preview {
    TextEditorView(markdownText: .constant("Test markdown"))
}


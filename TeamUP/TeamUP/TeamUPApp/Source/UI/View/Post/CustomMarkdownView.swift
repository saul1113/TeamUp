//
//  CustomMarkdownView.swift
//  TeamUP
//
//  Created by 김수민 on 11/18/24.
//

import SwiftUI
import MarkdownUI

struct CustomMarkdownView: UIViewRepresentable {
       @Binding var text: String
       @Binding var selectedRange: NSRange?

       class Coordinator: NSObject, UITextViewDelegate {
           var parent: CustomMarkdownView

           init(parent: CustomMarkdownView) {
               self.parent = parent
           }

           func textViewDidChange(_ textView: UITextView) {
               parent.text = textView.text
           }

           func textViewDidChangeSelection(_ textView: UITextView) {
               parent.selectedRange = textView.selectedRange
           }
       }

       func makeCoordinator() -> Coordinator {
           return Coordinator(parent: self)
       }

       func makeUIView(context: Context) -> UITextView {
           let textView = UITextView()
           textView.delegate = context.coordinator
           textView.font = UIFont.systemFont(ofSize: 14)
           textView.isEditable = true
           textView.isSelectable = true
           textView.text = text
           textView.autocorrectionType = .no
           return textView
       }

       func updateUIView(_ uiView: UITextView, context: Context) {
           uiView.text = text
           if let selectedRange = selectedRange {
               uiView.selectedRange = selectedRange
           }
       }
}





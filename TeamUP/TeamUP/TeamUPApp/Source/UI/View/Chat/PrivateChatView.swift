//
//  PrivateChatView.swift
//  TeamUP
//
//  Created by Hwang_Inyoung on 11/18/24.
//

import SwiftUI

struct PrivateChatMessage: Identifiable {
    let id = UUID()
    let message: String
    let image: Image
    let author: String
    let sendDate: Date
    var decodeToStringDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "오전 HH:mm"
        return formatter.string(from: sendDate)
    }
    static let dummyData: [PrivateChatMessage] = [
        PrivateChatMessage(message: "안녕하세요", image: Image(systemName: "person.crop.circle"), author: "Soom", sendDate: .distantPast),
        PrivateChatMessage(message: "집가고싶어요", image: Image(systemName: "person.crop.circle"), author: "sooso", sendDate: .distantPast),
        PrivateChatMessage(message: "전 배고파요", image: Image(systemName: "person.crop.circle"), author: "aaa", sendDate: .distantPast)
    ]
}
struct PrivateChatView: View {
    @State private var text: String = ""
    @State private var messages: [PrivateChatMessage] = PrivateChatMessage.dummyData
    let roomTitle: String
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                
                Spacer()
                    .frame(height: 20)
                
                ScrollView {
                    ForEach(messages, id: \.id) { message in
                        messageView(message: message)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem (placement: .topBarLeading) {
                        BackButtonBlack()
                    }
                    
                    ToolbarItem (placement: .principal) {
                        Text(roomTitle)
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                    }
                    ToolbarItem (placement: .topBarTrailing) {
                        Button {
                            
                        }label: {
                            Image(systemName: "line.3.horizontal")
                                .resizable()
                                .frame(width: 20,height: 15)
                                .foregroundStyle(.black)
                        }
                    }
                }
                Divider()
                textField()
            }
            .customPadding()
        }
    }
    func textField() -> some View {
        HStack {
            TextField("", text: $text)
                .padding(.vertical, 10)
                .padding(.leading, 10)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.gray, lineWidth: 0.5)
                }
            Button {
                messages.append(PrivateChatMessage(message: text, image: Image(systemName: ""), author: "Soom" , sendDate: .distantFuture))
                text = ""
            }label: {
                Image(systemName: "arrow.up.circle.fill")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .foregroundStyle(text.isEmpty ? .gray : Color.customBlue)
            }
            .disabled(text.isEmpty)
        }
        .customPadding()
    }
    @ViewBuilder
    func messageView(message: PrivateChatMessage) -> some View {
        if message.author == "Soom" {
            HStack (alignment: .bottom) {
                Text(message.decodeToStringDate)
                    .font(Font.regular12)
                    .foregroundStyle(.gray)
                Text(message.message)
                    .padding(.vertical, 12)
                    .customPadding()
                    .foregroundStyle(.black)
                    .background {
                        Rectangle()
                            .fill(Color.customBlue.opacity(0.5))
                            .cornerRadius(20, corners: [.topLeft, .bottomLeft, .bottomRight])
                    }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        } else {
            HStack ( alignment: .bottom ) {
                VStack {
                    message.image
                        .resizable()
                        .frame(width: 35,height: 35)
                    
                        .foregroundStyle(.gray)
                    Spacer()
                }
                VStack (alignment: .leading) {
                    Text(message.author)
                        .font(Font.semibold14)
                    Text(message.message)
                        .padding(.vertical, 12)
                        .customPadding()
                        .foregroundStyle(.black)
                        .background {
                            Rectangle()
                                .fill(Color.customGray)
                                .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                        }
                }
                Text(message.decodeToStringDate)
                    .font(Font.regular12)
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}





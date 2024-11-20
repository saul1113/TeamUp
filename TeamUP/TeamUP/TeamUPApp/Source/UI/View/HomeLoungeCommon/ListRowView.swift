//
//  PostRowView.swift
//  TeamUP
//
//  Created by wonhoKim on 11/18/24.
//

import SwiftUI

struct ListRowView: View {
    var model: Listable
    //@EnvironmentObject var authManager: AuthManager
    var isMyPage: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    if let post = model as? Post{
                        if post.isRecruit {
                            Text("모집중")
                                .font(.semibold12)
                                .foregroundColor(.customBlue)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 2)
                                .background(Color.customBlue.opacity(0.1))
                                .cornerRadius(4)
                        }
                        else {
                            Text("모집완료")
                                .font(.semibold12)
                                .foregroundColor(.white)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 4)
                                .background(Color.gray)
                                .cornerRadius(4)
                        }
                    }
                    Text(model.categoryString)
                        .font(.semibold12)
                        .foregroundColor(.gray)
                    Spacer()
                    
                    if isMyPage{
                        Button {
                            //리스트 삭제 같은 기능 올 곳
                        } label: {
                            Image(systemName: "ellipsis" )
                        }

                    }
                    
                }
               
                    Text(model.title)
                    .font(.semibold16)
                
                 
               
                Text(model.content)
                    .font(.regular12)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                
                HStack() {
                    Text(model.user.nickname)
                        .font(.regular12)
                    Text("•")
                    Text(model.time)
                        .font(.regular12)
                    Spacer()
                    HStack(spacing: 3){
                        Image(systemName: "bookmark.fill")
                        Text("\(model.save)")
                    }
                    
                    HStack(spacing: 3){
                        Image(systemName: "eye")
                        Text("\(model.seen)")
                    }
                    if let rounge = model as? Rounge {
                        HStack(spacing: 3){
                            Image(systemName: "bubble.left")
                            Text("\(rounge.reply.count)")
                        }
                    }
                
                }
                .font(.semibold12)
                .foregroundColor(.gray)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }
    }
}

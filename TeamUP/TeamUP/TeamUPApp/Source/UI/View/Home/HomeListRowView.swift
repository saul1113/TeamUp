//
//  PostRowView.swift
//  TeamUP
//
//  Created by wonhoKim on 11/18/24.
//

import SwiftUI

struct HomeListRowView: View {
    var model: Listable
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    if let post = model as? Post{
                        if post.isRecruit {
                            Text("모집중")
                                .font(.caption)
                                .foregroundColor(.blue)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 2)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(4)
                        }
                        else {
                            Text("모집완료")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 4)
                                .background(Color.gray)
                                .cornerRadius(4)
                        }
                    }
                    Text(model.categoryString)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                }
                Text(model.title)
                    .font(.headline)
                Text(model.content)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                
                HStack() {
                    Text(model.user)
                    Text("•")
                    Text(model.time)
                    
                    Spacer()
                    HStack(spacing: 3){
                        Image(systemName: "bookmark.fill")
                        Text("\(model.save)")
                    }
                    
                    HStack(spacing: 3){
                        Image(systemName: "eye")
                        Text("\(model.seen)")
                    }
                }
                .font(.caption)
                .foregroundColor(.gray)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }
    }
}

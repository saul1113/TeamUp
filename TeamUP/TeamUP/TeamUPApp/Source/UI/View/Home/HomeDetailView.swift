//
//  HomeDetailView.swift
//  TeamUP
//
//  Created by wonhoKim on 11/18/24.
//
import SwiftUI

struct DetailView: View {
    var post: Post
    
    var body: some View {
        VStack(spacing: 0) {
            // 상단 바
            HStack {
                BackButton()
                Spacer()
                Button(action: {
                    // 공유 로직
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // 카테고리 뱃지
                    Text(post.category.rawValue)
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(.blue)
                        .cornerRadius(4)
                    
                    // 작성자 정보
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Text(post.user.prefix(1))
                                    .font(.headline)
                                    .foregroundColor(.white)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(post.user)
                                .font(.headline)
                            HStack(spacing: 5) {
                                Text(post.time)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("•")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("조회수 \(post.seen)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        
                        Button {
                        //채팅 로직
                        } label: {
                            Text("1:1 채팅")
                                .font(.caption)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(4)
                        }

                       
                    }
                    Divider()
                    
                    PostDetailContentView(model: post)
                    
                    // 인원 정보
                    HStack {
                        Text("👤 \(2)/\(post.capacity)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Button {
                            
                        } label: {
                            
                        }

                        Image(systemName: "bookmark")
                        Text("\(post.save)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            
            Spacer()
            
            // 하단 버튼
            Button(action: {
                // 신청 로직
            }) {
                Text("신청하기")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .padding(.vertical, 10)
        }
        .navigationBarBackButtonHidden()
    }
}

//재사용 위한 분리

struct PostDetailContentView: View {
    var model: Post
    var body: some View {
        // 게시글 제목
        Text(model.title)
            .font(.title)
            .fontWeight(.bold)
        
        // 게시글 내용
        Text(model.content)
            .font(.body)
            .foregroundColor(.black.opacity(0.8))
        
        // 태그는 .. 모델 어케할지 모르겠어서 일단 더미로 넣었습니다
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(["알고리즘", "스터디", "모각코", "코딩해요"], id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(4)
                }
            }
        }
    }
}

#Preview {
    let samplePost = Post(category: .study, user: "수민이다", isRecruit: true, title: "강아지 잃어버리신분!!!", content: "여기 뚝도시장입니다 주인없이 돌아다니는데 찾으러 오세요", time: "4시간 전", save: 4, seen: 6, capacity: 5)
    DetailView(post: samplePost)
}

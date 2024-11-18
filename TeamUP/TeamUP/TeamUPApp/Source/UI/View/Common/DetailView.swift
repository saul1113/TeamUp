//
//  HomeDetailView.swift
//  TeamUP
//
//  Created by wonhoKim on 11/18/24.
//
import SwiftUI

struct DetailView: View {
    var model: Listable
    
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
                  
                    Text(model.categoryString)
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
                                Text(model.user.prefix(1))
                                    .font(.headline)
                                    .foregroundColor(.white)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(model.user)
                                .font(.headline)
                            HStack(spacing: 5) {
                                Text(model.time)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("•")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("조회수 \(model.seen)")
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
                    
                    DetailContentView(model: model)
                    
                    // 인원 정보
                    HStack {
                        if let post = model as? Post{
                            Text("👤 \(2)/\(post.capacity)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            
                        }

                        Image(systemName: "bookmark")
                        Text("\(model.save)")
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


#Preview {
    let samplePost = Post(category: .study, user: "수민이다", isRecruit: true, title: "강아지 잃어버리신분!!!", content: "배가고파서 집에서 나오는길 늘 그렇듯 늘어선 가로등은 타오르지 마치 싸울듯이 엉켜있었떤 머시기 시기지난 래퍼들의 반대편을 바라보던 래퍼들의 래퍼 그건 100프로 난 몰라요 하하하하 아무말이나 쓰는중 흐흐테스트 테스트 테스트 입니다 테스트 ", time: "4시간 전", save: 4, seen: 6, capacity: 5, hasTag: ["알고리즘","스터디","프로젝트"])
    DetailView(model: samplePost)
}

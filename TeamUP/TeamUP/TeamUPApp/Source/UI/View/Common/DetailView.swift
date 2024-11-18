//
//  HomeDetailView.swift
//  TeamUP
//
//  Created by wonhoKim on 11/18/24.
//
import SwiftUI

struct DetailView: View {
    var model: Listable
    @State private var saveCount: Int // `save` 값을 수정 가능한 변수로 관리
    @State private var isBookmarked = false
    // 모델이 수정 가능한 값으로 `save` 프로퍼티를 가지고 있다고 가정
    init(model: Listable) {
        self.model = model
        _saveCount = State(initialValue: model.save) // 초기값을 model.save로 설정
    }
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
                            //실제론 유저 프로필 이미지?
                            Text(model.user.nickname.prefix(1))
                                .font(.headline)
                                .foregroundColor(.white)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(model.user.nickname)
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
                    if model is Post{
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
                       //실제 저장 로직 와야함
                        
                        isBookmarked.toggle()
                        
                        
                        if isBookmarked {
                            saveCount += 1
                        } else {
                            saveCount -= 1
                        }
                    } label: {
                        
                        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                            .font(.title2)
                            .foregroundColor(.blue)
                        Text("\(saveCount)") // 변경된 saveCount 표시
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            
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
            .padding(60)
            
            
        }
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    let samplePost = Post(category: .study, user: User(email: "1231", password: "1231", nickname: "수민이다", profileImageName: "ㅁㄴㅇㄴㅇ"), isRecruit: true, title: "강아지 잃어버리신분!!!", content: "배가고파서 집에서 나오는길 늘 그렇듯 늘어선 가로등은 타오르지 마치 싸울듯이 엉켜있었떤 머시기 시기지난 래퍼들의 반대편을 바라보던 래퍼들의 래퍼 그건 100프로 난 몰라요 하하하하 아무말이나 반대편을 바라보던 래퍼들의 래퍼 그건 100프로 난 몰라요 늘 그렇듯 늘어선 가로등은 타오르지 마치 싸울듯이 엉켜있었떤 머시기 시기지난 래퍼들의 반대편을 바라보던 래퍼들의 래퍼 그건 100프로 난 몰라요  ", time: "4시간 전", save: 4, seen: 6, capacity: 5, hasTag: ["알고리즘","스터디","프로젝트"])
    DetailView(model: samplePost)
}

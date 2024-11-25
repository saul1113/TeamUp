//
//  HomeDetailView.swift
//  TeamUP
//
//  Created by wonhoKim on 11/18/24.
//
import SwiftUI

struct HomeLoungeDetailView: View {
    var model: Listable
    @Environment(ChatRoomViewModel.self) private var chatroomViewModel: ChatRoomViewModel
    @Environment(AuthManager.self) private var authManager: AuthManager
    @State private var saveCount: Int
    @State private var isBookmarked = false
    @State private var newComment = ""
    @State private var replies: [Reply]
    @State private var isShowingFriendProfile = false // 프로필 보기 플래그
    @State private var selectedUser: User? // 선택된 유저
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    let viewModel: ApplicationViewModel = ApplicationViewModel()
    @State private var isApplied = false
    // 모델이 수정 가능한 값으로 `save` 프로퍼티를 가지고 있다고 가정
    init(model: Listable) {
        self.model = model
        _saveCount = State(initialValue: model.save) // 초기값을 model.save로 설정
        if let rounge = model as? Rounge {
            _replies = State(initialValue: rounge.reply)
        } else {
            _replies = State(initialValue: [])
        }
    }
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text(model.categoryString)
                        .font(.semibold14)
                        .fontWeight(.bold)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(.customBlue.opacity(0.1))
                        .foregroundColor(.customBlue)
                        .cornerRadius(4)
                    
                    // 작성자 정보
                    HStack(spacing: 8) {
                        Button(action: {
                            // 작성자의 프로필을 보여주는 로직
                            selectedUser = model.user
                            print("Selected user: \(String(describing: selectedUser))")
                            print("Model user: \(String(describing: model.user))")
                            isShowingFriendProfile.toggle()
                        }) {
                            Circle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Text(model.user.nickname.prefix(1))
                                        .font(.bold16)
                                        .foregroundColor(.white)
                                )
                        }
                        .buttonStyle(PlainButtonStyle()) // 버튼 스타일 제거
                        
                        VStack(alignment: .leading) {
                            Text(model.user.nickname)
                                .font(.bold16)
                            HStack(spacing: 5) {
                                Text(formatTime: model.time)
                                    .font(.semibold12)
                                    .foregroundColor(.gray)
                                Text("•")
                                    .font(.semibold12)
                                    .foregroundColor(.gray)
                                Text("조회수 \(model.seen)")
                                    .font(.semibold12)
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        if model is Post{
                            Button {
                                //채팅 로직
                            } label: {
                                Text("1:1 채팅")
                                    .font(.semibold12)
                                    .foregroundColor(Color.customBlue)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 8)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(4)
                            }
                        }
                        
                        
                    }
                    Divider()
                    
                    HomeLoungeDetailContentView(model: model)
                    
                    // 인원 정보
                    HStack {
                        if let post = model as? PostModelStruct{
                            Image(systemName: "person.fill")
                                .padding(.trailing, 3)
                                .foregroundColor(.customDarkGray)
                            Text("\(post.currentUserCount) / \(post.maxUserCount)")
                                .font(.regular16)
                                .foregroundColor(.customDarkGray)
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
                                .foregroundColor(.customBlue)
                                .padding(.trailing, -5)
                            Text("\(saveCount)") // 변경된 saveCount 표시
                                .font(.regular14)
                                .foregroundColor(.black)
                        }
                        
                        
                    }
                    .frame(height: 10)
                    .padding(.top, 10)
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                //라운지일때
                if let rounge = model as? Rounge {
                    Divider()
                        .padding(.horizontal)
                    
                        .padding(.top, 30)
                    HStack{
                        Text("댓글")
                        Text("\(replies.count)")
                        
                        Spacer()
                    }
                    .padding()
                    
                    Divider()
                        .padding(.horizontal, 20)
                    
                    
                    VStack(alignment: .leading){
                        ForEach(replies) { reply in
                            VStack(alignment: .leading, spacing: 20) {
                                // 사용자 정보 및 작성 시간
                                HStack {
                                    Circle()
                                        .fill(Color.gray.opacity(0.5))
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            Text(reply.user.prefix(1))
                                                .font(.semibold16)
                                                .foregroundColor(.white)
                                        )
                                    
                                    VStack(alignment: .leading, spacing: 3) {
                                        Spacer().frame(height: 3)
                                        Text(reply.user)
                                            .font(.semibold16)
                                        Text(reply.timestamp, style: .relative) // 시간 포맷: "1시간 전"
                                            .font(.regular12)
                                            .foregroundColor(.gray)
                                        Text(reply.content)
                                            .font(.regular14)
                                            .foregroundColor(.black)
                                    }
                                    
                                    
                                }
                            }
                            Divider()
                            
                        }
                        HStack {
                            //로그인한 유저로 변경 필요
                            Circle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Text(rounge.user.nickname.prefix(1))
                                        .font(.semibold16)
                                        .foregroundColor(.white)
                                )
                            TextField("댓글을 입력해주세요", text: $newComment)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(height: 40)
                            
                            Button(action: {
                                addComment()
                            }) {
                                Image(systemName: "arrow.up.circle.fill")
                                    .resizable()
                                    .frame(width: 30,height: 30)
                                    .foregroundStyle(newComment.isEmpty ? .gray : Color.customBlue)
                                
                            }
                            .frame(height: 40)
                            
                            .disabled(newComment.isEmpty)
                        }
                        Spacer()
                    }
                    .padding(.horizontal,20)
                }
                //포스트(홈)일때
                if model is PostModelStruct {
                    
                    Spacer().frame(height: 40)
                    
                    Button(action: {

                        guard !isApplied else { return }
                        Task {
                            do {
                                try await viewModel.apply(postID: String(model.id))  // 실제 신청 로직 호출
                                try chatroomViewModel.addUser(postID: model.id, userEmail: authManager.user!.email)
                                alertMessage = "신청이 완료되었습니다."
                                showAlert = true
                                isApplied = true // 신청 완료 후 상태 업데이트
                            } catch {
                                alertMessage = "신청에 실패했습니다: \(error.localizedDescription)"
                                showAlert = true
                            }
                        }

                        

                    }) {
                        Text(isApplied ? "신청 완료" : "신청하기")
                            .font(.semibold20)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(width: 360, height: 50)
                            .background(isApplied ? Color.gray : Color.customBlue)
                            .cornerRadius(4)
                            .padding(.horizontal)
                           
                    }
                    .disabled(isApplied)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("알림"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
                    }
                    
                    
                }
                
            }
            .navigationBarBackButtonHidden()
        }.toolbar {
            ToolbarItem(placement: .topBarLeading) {
                
                BackButtonBlack()
            }
            ToolbarItem(placement: .topBarTrailing) {
                if model is Rounge {
                    ShareLink(
                        item: "TeamUpApp://lounge",
                        subject: Text("TeamUpApp"),
                        message: Text("게시글 공유")) {
                            Image(systemName: "square.and.arrow.up")
                        }
                        .foregroundStyle(.black)
                } else if model is Post {
                    ShareLink(
                        item: "TeamUpApp://post",
                        subject: Text("TeamUpApp"),
                        message: Text("게시글 공유")) {
                            Image(systemName: "square.and.arrow.up")
                        }
                        .foregroundStyle(.black)
                }
                
            }
        }
        .sheet(isPresented: $isShowingFriendProfile) {
                FriendProfileView(friend: selectedUser)
        }
        
    }
    
    private func addComment() {
        let newReply = Reply(user: "현재 유저", content: newComment, timestamp: Date())
        replies.append(newReply) // 댓글 배열에 새로운 댓글 추가
        newComment = "" // 입력 필드 초기화
    }
    
}



#Preview {
    let sampleRoungeData =
    Rounge(
        id: 1, category: .qna,
        user: User(id: UUID().uuidString, email: "add", password: "123", nickname: "ㅎㅎ", profileImageName: "String"),
        title: "새로운 규정 공지",
        content: "새로운 규정이 추가되었습니다. 자세한 사항은 공지사항을 참조해 주세요.새로운 규정이 추가되었습니다. 자세한 사항은 공지사항을 참조해 주세요새로운 규정이 추가되었습니다. 자세한 사항은 공지사항을 참조해 주세요새로운 규정이 추가되었습니다. 자세한 사항은 공지사항을 참조해 주세요새로운 규정이 추가되었습니다. 자세한 사항은 공지사항을 참조해 주세요새로운 규정이 추가되었습니다. 자세한 사항은 공지사항을 참조해 주세요",
        reply: [
            Reply(user: "Alice", content: "공지 확인했습니다. 감사합니다.", timestamp: Date()),
            Reply(user: "Bob", content: "규정 변경 관련 문의는 어디로 해야 하나요?", timestamp: Date()),
            Reply(user: "Charlie", content: "수고하셨습니다!", timestamp: Date()),
            Reply(user: "Charlie", content: "수고하셨습니다!", timestamp: Date())
            ,
            Reply(user: "Charlie", content: "수고하셨습니다!", timestamp: Date()),
            Reply(user: "Charlie", content: "수고하셨습니다!", timestamp: Date()),
        ],
        time: "2024-11-18 10:00",
        save: 120,
        seen: 350, hasTag: ["질문","궁금해요","스터디"]
    )
    let samplePost = Post(id: 1, category: .study, user: User(id: UUID().uuidString,email: "1231", password: "1231", nickname: "수민이다", profileImageName: "ㅁㄴㅇㄴㅇ"), isRecruit: true, title: "강아지 잃어버리신분!!!", content: "배가고파서 집에서 나오는길 늘 그렇듯 늘어선 가로등은 타오르지 마치 싸울듯이 엉켜있었떤 머시기 시기지난 래퍼들의 반대편을 바라보던 래퍼들의 래퍼 그건 100프로 난 몰라요 하하하하 아무말이나 반대편을 바라보던 래퍼들의 래퍼 그건 100프로 난 몰라요 늘 그렇듯 늘어선 가로등은 타오르지 마치 싸울듯이 엉켜있었떤 머시기 시기지난 래퍼들의 반대편을 바라보던 래퍼들의 래퍼 그건 100프로 난 몰라요  ", time: "4시간 전", save: 4, seen: 6, maxCapacity: 5, currentCapacity: 2 ,hasTag: ["알고리즘","스터디","프로젝트"])
    HomeLoungeDetailView(model: sampleRoungeData)
}

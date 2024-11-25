//
//  HomeView.swift
//  ProjectMoyo
//
//  Created by wonhoKim on 11/15/24.
//


import SwiftUI

// 샘플 게시글 데이터
let samplePostData = [
    Post(id: 1, category: .study, user: User(id: UUID().uuidString,email: "add", password: "123", nickname: "하이요", profileImageName: "String"), isRecruit: true, title: "강아지 잃어버리신분!!!", content: "여기 뚝도시장입니다 주인없이 돌아다니는데 찾으러 오세요", time: "4시간 전", save: 4, seen: 6, maxCapacity: 5, currentCapacity: 2 ,hasTag: ["알고리즘","스터디","프로젝트"]),
    Post(id: 2, category: .project, user: User(id: UUID().uuidString,email: "add", password: "123", nickname: "메롱", profileImageName: "String"), isRecruit: true, title: "건물안에서 갇혔는데 열어주실분", content: "독카실용음악학원 4층인데요 지금 오셔서 열어주시면 감사하겠습니다.여러분 오늘 점심 뭐 먹을지 고민인데 추천 좀 해주세요!여러분 오늘 점심 뭐 먹을지 고민인데 추천 좀 해주세요!여러분 오늘 점심 뭐 먹을지 고민인데 추천 좀 해주세요!여러분 오늘 점심 뭐 먹을지 고민인데 추천 좀 해주세요!여러분 오늘 점심 뭐 먹을지 고민인데 추천 좀 해주세요!여러분 오늘 점심 뭐 먹을지 고민인데 추천 좀 해주세요!여러분 오늘 점심 뭐 먹을지 고민인데 추천 좀 해주세요!여러분 오늘 점심 뭐 먹을지 고민인데 추천 좀 해주세요!", time: "1일 전", save: 4, seen: 6, maxCapacity: 5, currentCapacity: 2 , hasTag: ["알고리즘","스터디","프로젝트"]),
    Post(id: 3, category: .study, user: User(id: UUID().uuidString,email: "add", password: "123", nickname: "ㅋㅋ맨", profileImageName: "String"), isRecruit: false, title: "강아지 보호소 괜찮을까요", content:
            """
## 프로젝트 개요
- **주제:** SwiftUI를 활용한 협업 툴 개발
- **목표:** 사용자 친화적인 UI와 효율적인 팀 관리 기능 제공
- **기간:** 2024년 12월 ~ 2025년 2월
1. **개발 경험**
- SwiftUI 또는 iOS 개발 경험이 있는 분
- Git과 협업 툴 사용 경험 필수
2. **커뮤니케이션**
- 팀원들과 원활한 소통이 가능한 분
- 주 1회 회의 참여
3. **기타**
- 꾸준히 학습하고 피드백을 주고받을 수 있는 자세
---
### 프로젝트 주요 기능
- **Task 관리**
- 할 일 추가, 수정, 삭제
- 마감 기한 설정 기능
- **채팅**
- 실시간 채팅 및 파일 공유
- 이모티콘 및 반응 기능
- **통계**
- 프로젝트 진행 상황 차트로 시각화
- 팀 생산성 지표 분석
---
""", time: "43분 전", save: 8, seen: 2, maxCapacity: 6, currentCapacity: 6 ,hasTag: ["알고리즘","스터디","프로젝트"])
]


struct HomeView: View {
    @Environment(PostViewModel.self) private var postViewModel: PostViewModel
    @State private var selectedCategory: PostCategory?
    @State private var isSheetPresented = false
    @State private var searchText: String = ""
    @State private var selectedSort: String = "최신순"
    @State private var isRecruit: Bool = false
    
    // 검색 필터
    var filteredItems: [PostModelStruct] {
        var items = postViewModel.posts
        
        // 검색 텍스트 필터링
        if !searchText.isEmpty {
            items = items.filter { item in
                item.title.localizedCaseInsensitiveContains(searchText) ||
                item.content.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // "모집중" 필터링
        if isRecruit {
            items = items.filter { $0.isRecruit == 1 }  // 리크루트 트루만 필터링
        }
        
        return items
    }
    
    var sortedItems: [PostModelStruct] {
        switch selectedSort {
        case "최신순":
            return filteredItems.sorted { $0.time > $1.time }
        case "저장많은순":
            return filteredItems.sorted { $0.save > $1.save }
        case "조회순":
            return filteredItems.sorted { $0.seen > $1.seen }
        default:
            return filteredItems
        }
    }
    var body: some View {
        VStack(alignment: .leading) {
            CustomSearchBar(searchText: $searchText, placeholder: "검색어를 입력해주세요 (ex 웹프로젝트, 알고리즘 스터디", onSearch: { text in
                print("검색실행")
            })
            .padding(.horizontal)
            
            // 스터디 카테고리 필터링
            HStack (spacing: 22){
                ForEach([nil] + PostCategory.allCases, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                    }) {
                        VStack(spacing: 2){
                            Text(category?.rawValue ?? "전체")
                                .font(.semibold20)
                                .foregroundColor(selectedCategory == category ? .black : .gray)
                                .background(
                                    VStack {
                                        Spacer()
                                        if selectedCategory == category {
                                            Rectangle()
                                                .frame(height: 2)
                                                .foregroundColor(.customBlue)
                                                .animation(.easeInOut, value: selectedCategory)
                                        }
                                    }
                                )
//                                .onTapGesture {
//                                    withAnimation(.easeInOut) {
//                                        selectedCategory = category
//                                    }
//                                }
                        }
                    }
                }
                Spacer() // 버튼들을 왼쪽으로 밀기
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            
            
            // 최신순 저장많은순 조회순 필터링
            HStack (spacing: 15){
                Button(action: {
                    selectedSort = "최신순"
                }) {
                    Text("• 최신순")
                        .foregroundColor(selectedSort == "최신순" ? .customBlue : .gray)
                        .font(.medium14)
                }
                
                Button(action: {
                    selectedSort = "저장많은순"
                }) {
                    Text("• 저장많은순")
                        .foregroundColor(selectedSort == "저장많은순" ? .customBlue : .gray)
                        .font(.medium14)
                }
                
                Button(action: {
                    selectedSort = "조회순"
                }) {
                    Text("• 조회순")
                        .foregroundColor(selectedSort == "조회순" ? .customBlue : .gray)
                        .font(.medium14)
                }
            }
            .padding(.horizontal)
            //.padding(.bottom, 10)
            
            // 모집중 필터링
            HStack(spacing: 0) {
                Spacer()
                Toggle(isOn: $isRecruit) {
                    Text("모집중만 보기")
                        .font(.semibold12)
                        .foregroundStyle(Color.black)
                }
                .toggleStyle(CustomCheckBox())
                .padding(.horizontal)
                
            }.padding(.bottom, -15)
            
            ScrollView {
                ForEach(sortedItems.filter { post in
                    if let selectedCategory = selectedCategory {
                        return post.categoryString == selectedCategory.rawValue
                    }
                    return true
                }, id: \.title) { post in
                    
                    Divider()
                    
                    NavigationLink(destination: HomeLoungeDetailView(model: post)) {  // NavigationLink 추가
                        ListRowView(model: post, isMyPage: false)
                            .padding(.vertical, 2)
                    }
                }
                .padding(20)
            }
            
            Spacer()
        }
        
    }
}

struct CustomCheckBox: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(.customBlue)
                configuration.label
            }
        })
    }
}



extension Text {
    init(formatTime: String, dateFormat: String = "yyyy-MM-dd HH:mm") {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = dateFormat
        displayFormatter.locale = Locale(identifier: "ko_KR")
        displayFormatter.timeZone = TimeZone.current
        
        if let date = isoFormatter.date(from: formatTime) {
            self.init(displayFormatter.string(from: date))
        } else {
            self.init(formatTime)
        }
    }
}


#Preview {
    HomeView()
        .environment(PostViewModel())
}

//
//  HomeView.swift
//  ProjectMoyo
//
//  Created by wonhoKim on 11/15/24.
//


import SwiftUI

// 샘플 게시글 데이터
let samplePostData = [
    Post(category: .study, user: User(id: UUID().uuidString,email: "add", password: "123", nickname: "하이요", profileImageName: "String"), isRecruit: true, title: "강아지 잃어버리신분!!!", content: "여기 뚝도시장입니다 주인없이 돌아다니는데 찾으러 오세요", time: "4시간 전", save: 4, seen: 6, maxCapacity: 5, currentCapacity: 2 ,hasTag: ["알고리즘","스터디","프로젝트"]),
    Post(category: .project, user: User(id: UUID().uuidString,email: "add", password: "123", nickname: "메롱", profileImageName: "String"), isRecruit: true, title: "건물안에서 갇혔는데 열어주실분", content: "독카실용음악학원 4층인데요 지금 오셔서 열어주시면 감사하겠습니다.여러분 오늘 점심 뭐 먹을지 고민인데 추천 좀 해주세요!여러분 오늘 점심 뭐 먹을지 고민인데 추천 좀 해주세요!여러분 오늘 점심 뭐 먹을지 고민인데 추천 좀 해주세요!여러분 오늘 점심 뭐 먹을지 고민인데 추천 좀 해주세요!여러분 오늘 점심 뭐 먹을지 고민인데 추천 좀 해주세요!여러분 오늘 점심 뭐 먹을지 고민인데 추천 좀 해주세요!여러분 오늘 점심 뭐 먹을지 고민인데 추천 좀 해주세요!여러분 오늘 점심 뭐 먹을지 고민인데 추천 좀 해주세요!", time: "1일 전", save: 4, seen: 6, maxCapacity: 5, currentCapacity: 2 , hasTag: ["알고리즘","스터디","프로젝트"]),
    Post(category: .study, user: User(id: UUID().uuidString,email: "add", password: "123", nickname: "ㅋㅋ맨", profileImageName: "String"), isRecruit: false, title: "강아지 보호소 괜찮을까요", content: "동네 강아지 주인분이 포기하셔서 제가 임시보호 하고 있는데...", time: "43분 전", save: 8, seen: 2, maxCapacity: 6, currentCapacity: 6 ,hasTag: ["알고리즘","스터디","프로젝트"])
]

struct HomeView: View {
    @State private var selectedCategory: PostCategory?
    @State private var isSheetPresented = false
    @State private var searchText: String = ""
    @State private var selectedSort: String = "최신순"
    @State private var isRecruit: Bool = false

    // 검색 필터
    var filteredItems: [Post] {
        var items = samplePostData
        
        // 검색 텍스트 필터링
        if !searchText.isEmpty {
            items = items.filter { item in
                item.title.localizedCaseInsensitiveContains(searchText) ||
                item.content.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // "이즈인크루트" 필터링
        if isRecruit {
            items = items.filter { $0.isRecruit }  // 리크루트 트루만 필터링
        }
        
        return items
    }
    
    var sortedItems: [Post] {
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
        NavigationView {  // NavigationView로 감싸기
            VStack(alignment: .leading) {
                CustomSearchBar(searchText: $searchText, placeholder: "검색어를 입력해주세요 (ex 웹프로젝트, 알고리즘 스터디", onSearch: { text in
                    print("검색실행")
                })
                .padding(.horizontal)
                
                // 스터디 카테고리 필터링
                HStack(spacing: 5) {
                    ForEach([nil] + PostCategory.allCases, id: \.self) { category in
                        Button(action: {
                            selectedCategory = category
                        }) {
                            VStack(spacing: 2){
                                Text(category?.rawValue ?? "전체")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(selectedCategory == category ? .black : .gray)
                                if selectedCategory == category {
                                    Rectangle()
                                        .frame(width: 30, height: 2)
                                        .foregroundColor(.blue)
                                        .animation(.easeInOut, value: selectedCategory)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 3)
                            .padding(.bottom, 10)
                        }
                    }
                    Spacer() // 버튼들을 왼쪽으로 밀기
                }
                
                // 최신순 저장많은순 조회순 필터링
                HStack {
                    Button(action: {
                        selectedSort = "최신순"
                    }) {
                        Text("• 최신순")
                            .foregroundColor(selectedSort == "최신순" ? .blue : .gray)
                    }
                    
                    Button(action: {
                        selectedSort = "저장많은순"
                    }) {
                        Text("• 저장많은순")
                            .foregroundColor(selectedSort == "저장많은순" ? .blue : .gray)
                    }
                    
                    Button(action: {
                        selectedSort = "조회순"
                    }) {
                        Text("• 조회순")
                            .foregroundColor(selectedSort == "조회순" ? .blue : .gray)
                    }
                }
                .padding(.horizontal)
                .font(.caption)
                .padding(.bottom, 10)
                
                // 모집중 필터링
                Toggle(isOn: $isRecruit) {
                    Text("모집중만 보기")
                        .font(.caption)
                        .foregroundStyle(Color.black)
                }
                .toggleStyle(CustomCheckBox())
                .padding(.horizontal)
                Divider()
                
                // 게시글 리스트
                List {
                    ForEach(sortedItems.filter { post in
                        if let selectedCategory = selectedCategory {
                            return post.category == selectedCategory
                        }
                        return true
                    }, id: \.title) { post in
                        NavigationLink(destination: HomeLoungeDetailView(model: post)) {  // NavigationLink 추가
                            ListRowView(model: post)
                                //.padding(.vertical, 5)
                        }
                        
                    }
                }
                .listStyle(PlainListStyle())
            }
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
                configuration.label
            }
        })
    }
}





#Preview {
    HomeView()
}

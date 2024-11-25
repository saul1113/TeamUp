//
//  LoungeView.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI

struct LoungeView: View {
    @State private var selectedCategory: RoungeCategory?
    @State private var isSheetPresented = false
    @State private var searchText: String = ""
    @State private var selectedSort: String = "최신순"
    
    var filteredItems: [Rounge] {
        var items = sampleRoungeData
        
        // 검색 텍스트 필터링
        if !searchText.isEmpty {
            items = items.filter { item in
                item.title.localizedCaseInsensitiveContains(searchText) ||
                item.content.localizedCaseInsensitiveContains(searchText)
            }
        }
        return items
    }
    
    var sortedItems: [Rounge] {
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
            CustomSearchBar(searchText: $searchText, placeholder: "검색어를 입력해주세요", onSearch: { text in
                print("검색실행")
            })
            .padding(.horizontal)
            
            
            HStack (spacing: 20){
                ForEach([nil] + RoungeCategory.allCases, id: \.self) { category in
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
                                                .padding(.top, 4)
                                                .animation(.easeInOut, value: selectedCategory)
                                        }
                                    }
                                )
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
            .padding(.bottom, -10)
            
            ScrollView {
                VStack (spacing: 10) {
                    ForEach(sortedItems.filter { rounge in
                        if let selectedCategory = selectedCategory {
                            return rounge.category == selectedCategory
                        }
                        return true
                    }, id: \.title) { rounge in
                        
                        Divider()
                        
                        NavigationLink(destination: HomeLoungeDetailView(model: rounge)) {  // NavigationLink 추가
                            ListRowView(model: rounge, isMyPage: false)
                                .padding(.vertical, 2)
                        }
                    }
                    
                }.padding(20)
            }
            
            Spacer()
            
        }
        
    }
}
#Preview {
    LoungeView()
}

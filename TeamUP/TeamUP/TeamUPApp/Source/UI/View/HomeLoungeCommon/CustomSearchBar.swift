//
//  CustomSearchBar.swift
//  TeamUP
//
//  Created by wonhoKim on 11/18/24.
//
import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchText: String
    var placeholder: String
    var onSearch: (String) -> Void
    @State private var isSearching: Bool = false // 검색 중 여부
    
    var body: some View {
        HStack {
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField(placeholder, text: $searchText, onEditingChanged: { isEditing in
                    isSearching = isEditing
                })
                .foregroundColor(.primary)
                .font(.regular14)
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            
            // 취소 버튼
            if isSearching {
                Button(action: {
                    searchText = ""
                    isSearching = false
                    //이거 유아이킷 밖에 없나요?
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("취소")
                        .foregroundColor(.customBlue)
                }
                .animation(.easeInOut, value: isSearching) //후에 수정
            }
        }
    }
}

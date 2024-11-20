//
//  CategorySelectedView.swift
//  TeamUP
//
//  Created by 김수민 on 11/19/24.
//


import SwiftUI

enum CategoryTab: Int, CaseIterable {
    case project
    case study
    case qAndA
    case etc
}

struct CategorySelectedView: View {
    @Binding var selectedTab: CategoryTab
    
    var body: some View {
        VStack {
            HStack (alignment: .bottom,spacing: 0){
                Button {
                    selectedTab = .project
                }label: {
                    VStack{
                        Text("프로젝트")
                            .frame(maxWidth: .infinity)
                        Rectangle()
                            .fill(selectedTab == .project ? Color.customBlue : Color.gray)
                            .frame(height: selectedTab == .project ? 3 : 0.4)
                    }
                }
                Button {
                    selectedTab = .study
                }label: {
                    VStack {
                        Text("스터디")
                            .frame(maxWidth: .infinity)
                        Rectangle()
                            .fill(selectedTab == .study ? Color.customBlue : Color.gray)
                            .frame(height:selectedTab == .study ? 3 : 0.4)
                    }
                }
                
                Button {
                    selectedTab = .qAndA
                }label: {
                    VStack {
                        Text("Q & A")
                            .frame(maxWidth: .infinity)
                        Rectangle()
                            .fill(selectedTab == .qAndA ? Color.customBlue : Color.gray)
                            .frame(height: selectedTab == .qAndA ? 3 : 0.4)
                    }
                }
                Button {
                    selectedTab = .etc
                }label: {
                    VStack {
                        Text("잡답")
                            .frame(maxWidth: .infinity)
                        Rectangle()
                            .fill(selectedTab == .etc ? Color.customBlue : Color.gray)
                            .frame(height:selectedTab == .etc ? 3 : 0.4)
                    }
                }
            }
            .font(.semibold14)
            .foregroundStyle(.black)
            .padding(.horizontal, 5)
        }
    }
    
}

#Preview {
    CategorySelectedView(selectedTab: .constant(.project))
}


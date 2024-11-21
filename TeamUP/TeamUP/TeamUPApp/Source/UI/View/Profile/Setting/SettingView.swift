//
//  SettingView.swift
//  TeamUP
//
//  Created by Jaemin Hong on 11/17/24.
//

import SwiftUI

struct SettingView: View {
    @State private var notificationOn: Bool = true
    private let padding: CGFloat = 20
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("설정")
                .font(.bold24)
                .padding(.horizontal, padding)
            
            List {
                Toggle("알림 허용", isOn: $notificationOn)
                
                Divider()
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                
                NavigationLink {
                    Text("차단당함")
                        .backButton()
                } label: {
                    Text("차단목록")
                        .foregroundStyle(.black)
                }
                .listRowSeparator(.hidden)
                
                Divider()
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .listRowInsets(EdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding))
            .environment(\.defaultMinListRowHeight, 0)
        }
        .navigationTitle("설정")
        .font(.regular18)
        .navigationBarBackButtonHidden(true)
        .onChange(of: notificationOn) {
            if notificationOn {
                // TODO: 알림 수신 설정 변경
            }
        }
        .toolbar {
            ToolbarItem (placement: .topBarLeading) {
                BackButtonBlack()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingView()
    }
}

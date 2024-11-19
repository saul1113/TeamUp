//
//  PostView.swift
//  ProjectMoyo
//
//  Created by Soom on 11/15/24.
//

import SwiftUI

struct PostView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    TextEditorView()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    
                }label: {
                    BackButton()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button {
                        
                    }label: {
                        
                    }
                    
                    Button {
                        
                    }label: {
                        
                    }
                }
            }
        }
        .navigationTitle("")
    }
}

#Preview {
    PostView()
}

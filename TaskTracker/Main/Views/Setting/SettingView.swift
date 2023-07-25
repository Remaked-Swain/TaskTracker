//
//  SettingView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/25.
//

import SwiftUI

struct SettingView: View {
    @Binding var isPresentedMenu: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.secondarySystemBackground).ignoresSafeArea()
                
                VStack(spacing: 30) {
                    NavigationLink {
                        // Theme
                    } label: {
                        VStack {
                            Image(systemName: "paintbrush")
                                .resizable()
                                .scaledToFit()
                            Text("테마 변경")
                                .font(.headline)
                        }
                        .modifier(SettingButtonModifier())
                    }
                    
                    NavigationLink {
                        // Theme
                    } label: {
                        VStack {
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .scaledToFit()
                            Text("도움말")
                                .font(.headline)
                        }
                        .modifier(SettingButtonModifier())
                    }
                }
            }
            .navigationTitle(Stage.setting.id)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation(.spring()) {
                            isPresentedMenu.toggle()
                        }
                    } label: {
                        Image(systemName: isPresentedMenu ? "xmark" : "line.3.horizontal")
                            .font(.headline)
                            .imageScale(.large)
                            .opacity(isPresentedMenu ? 0 : 1)
                    }
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isPresentedMenu: .constant(false))
    }
}

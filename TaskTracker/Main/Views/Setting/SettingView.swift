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
                List {
                    NavigationLink {
                        HelpView()
                    } label: {
                        Image(systemName: "questionmark.bubble")
                            .foregroundColor(.accentColor)
                        Text("도움말")
                    }
                    
                    NavigationLink {
                        DeveloperInfoView()
                    } label: {
                        Image(systemName: "doc.append")
                            .foregroundColor(.accentColor)
                        Text("개발자 정보")
                    }
                }
                .font(.headline)
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

//
//  SettingView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/25.
//

import SwiftUI

struct SettingView: View {
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    
                }
            }
            .navigationTitle(Stage.setting.id)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

//
//  StageTab.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/24.
//

import SwiftUI

struct StageTab: View {
    @EnvironmentObject private var coreVM: CoreViewModel
    @Binding var isPresentedMenu: Bool
    @Binding var selectedStage: Stage
    
    var body: some View {
        TabView(selection: $selectedStage) {
            CoreView(isPresentedMenu: $isPresentedMenu)
                .tag(Stage.core)
                .environmentObject(coreVM)
            
            CategoriesView(isPresentedMenu: $isPresentedMenu)
                .tag(Stage.categories)
                .environmentObject(coreVM)
            
            SettingView(isPresentedMenu: $isPresentedMenu)
                .tag(Stage.setting)
        }
    }
}

//
//  StageTab.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/24.
//

import SwiftUI

struct StageTab: View {
    @EnvironmentObject private var stagingVM: StagingViewModel
    @EnvironmentObject private var coreVM: CoreViewModel
    
    var body: some View {
        TabView(selection: $stagingVM.selectedStage) {
            CoreView(isPresentedMenu: $stagingVM.isPresentedMenu)
                .tag(Stage.core)
                .environmentObject(coreVM)
            
            CategoriesView(isPresentedMenu: $stagingVM.isPresentedMenu)
                .tag(Stage.categories)
                .environmentObject(coreVM)
            
            SettingView(isPresentedMenu: $stagingVM.isPresentedMenu)
                .tag(Stage.setting)
        }
    }
}

struct StageTab_Previews: PreviewProvider {
    static var previews: some View {
        StageTab()
            .environmentObject(StagingViewModel())
            .environmentObject(CoreViewModel(coreDataManager: CoreDataManager.shared))
    }
}

//
//  StageTab.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/24.
//

import SwiftUI

struct StageTab: View {
    @EnvironmentObject private var stagingVM: StagingViewModel
    @State private var coreVM: CoreViewModel = CoreViewModel(coreDataManager: CoreDataManager.shared)
    
    var body: some View {
        TabView(selection: $stagingVM.selectedStage) {
            CoreView(isPresentedMenu: $stagingVM.isPresentedMenu)
                .tag(Stage.core)
                .environmentObject(coreVM)
            
            CategoriesView(isPresentedMenu: $stagingVM.isPresentedMenu)
                .tag(Stage.categories)
                .environmentObject(coreVM)
        }
    }
}

struct StageTab_Previews: PreviewProvider {
    static var previews: some View {
        StageTab()
            .environmentObject(StagingViewModel())
    }
}

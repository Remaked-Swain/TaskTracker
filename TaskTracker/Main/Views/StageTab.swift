//
//  StageTab.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/24.
//

import SwiftUI

struct StageTab: View {
    @EnvironmentObject private var stagingVM: StagingViewModel
    
    var body: some View {
        TabView(selection: $stagingVM.selectedStage) {
            CoreView()
                .tag(Stage.core)
                .environmentObject(stagingVM)
            
            CategoriesView()
                .tag(Stage.categories)
                .environmentObject(stagingVM)
        }
    }
}

struct StageTab_Previews: PreviewProvider {
    static var previews: some View {
        StageTab()
            .environmentObject(StagingViewModel(coreVM: CoreViewModel(coreDataManager: CoreDataManager.shared)))
    }
}

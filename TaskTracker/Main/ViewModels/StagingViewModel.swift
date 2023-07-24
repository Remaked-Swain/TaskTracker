//
//  StagingViewModel.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/23.
//

import Foundation

class StagingViewModel: ObservableObject {
    @Published var selectedStage: Stage = .core
    @Published var isPresentedMenu: Bool = false
    
    let coreVM: CoreViewModel
    
    let stages: [Stage] = Stage.allCases
    
    init(coreVM: CoreViewModel) {
        self.coreVM = coreVM
    }
}

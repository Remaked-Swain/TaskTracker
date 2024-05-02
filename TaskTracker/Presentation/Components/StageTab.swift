//
//  StageTab.swift
//  TaskTracker
//
//  Created by Swain Yun on 3/31/24.
//

import SwiftUI

struct StageTab<ViewModel: CoreViewModel>: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        TabView(selection: $viewModel.selectedStage) {
            TaskListView(viewModel: viewModel)
        }
    }
}

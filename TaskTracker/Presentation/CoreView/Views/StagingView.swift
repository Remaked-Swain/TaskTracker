//
//  StagingView.swift
//  TaskTracker
//
//  Created by Swain Yun on 3/30/24.
//

import SwiftUI

struct StagingView: View {
    @StateObject private var stagingViewModel: StagingViewModel
    
    init(fetchTasksCompletionRateUseCase: FetchTasksCompletionRateUseCase) {
        self._stagingViewModel = StateObject(wrappedValue: StagingViewModel(fetchTasksCompletionRateUseCase: fetchTasksCompletionRateUseCase))
    }
    
    var body: some View {
        ZStack {
            // Background Layer
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            ScrollView {
                sideMenu
            }.scrollIndicators(.hidden)
        }
    }
}

#Preview {
    StagingView(fetchTasksCompletionRateUseCase: DefaultFetchTasksCompletionRateUseCase(taskListRepository: DefaultTaskListRepository()))
}

extension StagingView {
    private var sideMenu: some View {
        // Side Menu
        VStack(alignment: .leading, spacing: 30) {
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 30) {
                    profilePicture
                }
            }
        }
    }
    
    private var profilePicture: some View {
        ZStack(alignment: .center) {
            ProgressCircleView(progress: $stagingViewModel.tasksCompletionRate)
                .frame(width: 100, height: 100)
            
            Image("dev-jeans")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
        }
    }
}

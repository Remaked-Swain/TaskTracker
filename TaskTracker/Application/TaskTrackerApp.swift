//
//  TaskTrackerApp.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/14.
//

import SwiftUI

@main
struct TaskTrackerApp: App {
    private let container: DependencyContainer = {
        let container = DefaultDependencyContainer()
        container.
    }()
    
    var body: some Scene {
        WindowGroup {
            StagingView(fetchTasksCompletionRateUseCase: fetchTasksCompletionRateUseCase)
        }
    }
}

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
        container.register(for: DefaultTaskListRepository.self, with: DefaultTaskListRepository())
        container.register(for: DefaultFetchTasksCompletionRateUseCase.self) { resolver in
            DefaultFetchTasksCompletionRateUseCase(taskListRepository: resolver.resolve(for: DefaultTaskListRepository.self))
        }
        container.register(for: DefaultCoreViewModel.self) { resolver in
            DefaultCoreViewModel(fetchTasksCompletionRateUseCase: resolver.resolve(for: DefaultFetchTasksCompletionRateUseCase.self))
        }
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            CoreView(viewModel: container.resolve(for: DefaultCoreViewModel.self))
        }
    }
}

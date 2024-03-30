//
//  FetchTasksCompletionRateUseCase.swift
//  TaskTracker
//
//  Created by Swain Yun on 3/30/24.
//

import Foundation

protocol FetchTasksCompletionRateUseCase {
    func fetchTasksComletionRate() async -> CGFloat
}

final class DefaultFetchTasksCompletionRateUseCase {
    private let taskListRepository: TaskListRepository
    
    init(taskListRepository: TaskListRepository) {
        self.taskListRepository = taskListRepository
    }
}

// MARK: FetchTasksCompletionRateUseCase Confirmation
extension DefaultFetchTasksCompletionRateUseCase: FetchTasksCompletionRateUseCase {
    func fetchTasksComletionRate() async -> CGFloat {
        await taskListRepository.fetchTasksCompletionRate()
    }
}

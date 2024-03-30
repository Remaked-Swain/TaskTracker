//
//  FetchTaskListUseCase.swift
//  TaskTracker
//
//  Created by Swain Yun on 3/30/24.
//

import Foundation

protocol FetchTaskListUseCase {
    func fetchTaskList() async -> [TaskModel]
}

final class DefaultFetchTaskListUseCase {
    private let taskListRepository: TaskListRepository
    
    init(taskListRepository: TaskListRepository) {
        self.taskListRepository = taskListRepository
    }
}

// MARK: FetchTaskListUseCase Confirmation
extension DefaultFetchTaskListUseCase: FetchTaskListUseCase {
    func fetchTaskList() async -> [TaskModel] {
        await taskListRepository.fetchTaskList()
    }
}

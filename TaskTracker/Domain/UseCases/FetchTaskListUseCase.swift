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

final class DefaultFetchTaskListRepositoryUseCase: FetchTaskListUseCase {
    private let taskListRepository: TaskListRepository
    
    init(taskListRepository: TaskListRepository) {
        self.taskListRepository = taskListRepository
    }
    
    func fetchTaskList() async -> [TaskModel] {
        await taskListRepository.fetchTaskList()
    }
}

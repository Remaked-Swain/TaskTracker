//
//  TaskListRepository.swift
//  TaskTracker
//
//  Created by Swain Yun on 3/30/24.
//

import Foundation

protocol TaskListRepository {
    func fetchTaskList() async -> [TaskModel]
    func saveTask(task: TaskModel)
    func fetchTasksCompletionRate() async -> CGFloat
}

final class DefaultTaskListRepository {
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage = .shared) {
        self.coreDataStorage = coreDataStorage
    }
}

// MARK: TaskListRepository Confirmation
extension DefaultTaskListRepository: TaskListRepository {
    func fetchTaskList() async -> [TaskModel] {
        []
    }
    
    func saveTask(task: TaskModel) {
        //
    }
    
    func fetchTasksCompletionRate() async -> CGFloat {
        return 0.45
    }
}

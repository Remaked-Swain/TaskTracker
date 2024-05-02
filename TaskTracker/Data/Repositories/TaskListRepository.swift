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
    func calculateRemainingTime(to deadline: Date) -> Date?
}

final class DefaultTaskListRepository {
    private let coreDataStorage: CoreDataStorage
    private let calendarService: CalendarService
    
    init(coreDataStorage: CoreDataStorage = .shared, calendarService: CalendarService) {
        self.coreDataStorage = coreDataStorage
        self.calendarService = calendarService
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
    
    func calculateRemainingTime(to deadline: Date) -> Date? {
        return calendarService.calculateRemainingTime(to: deadline)
    }
}

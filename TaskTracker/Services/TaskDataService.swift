//
//  TaskDataService.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/17.
//

import Foundation
import Combine

class TaskDataService: ObservableObject {
    private var allTasks: [TaskModel] = []
    
    private let coreDataManager = CoreDataManager.shared
    
    init() {
        fetchTasks()
    }
    
    private func fetchTasks() {
        coreDataManager.fetchTasks { [weak self] taskEntities in
            let tasks = taskEntities.compactMap { taskEntity -> TaskModel? in
                guard
                    let id = taskEntity.id,
                    let title = taskEntity.title,
                    let taskDescription = taskEntity.taskDescription,
                    let deadline = taskEntity.deadline,
                    let category = taskEntity.category
                else { return nil }

                return TaskModel(
                    id: id,
                    title: title,
                    taskDescription: taskDescription,
                    deadline: deadline,
                    isCompleted: taskEntity.isCompleted,
                    category: category
                )
            }

            DispatchQueue.main.async {
                self?.allTasks = tasks
            }
        }
    }
    
    func createTask(_ task: TaskModel) {
        coreDataManager.saveTask(task)
        fetchTasks()
    }
    
    func readTasks() -> [TaskModel] {
        fetchTasks()
        return self.allTasks
    }
    
    func updateTask(_ task: TaskModel) {
        coreDataManager.updateTask(task)
        fetchTasks()
    }
    
    func deleteTask(_ task: TaskModel) {
        coreDataManager.deleteTask(task)
        fetchTasks()
    }
}

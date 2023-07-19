//
//  TaskDataService.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/17.
//

import Foundation
import Combine

class TaskDataService: ObservableObject {
    @Published var allTasks: [TaskModel] = []
    
    private let coreDataManager = CoreDataManager.shared
    
    init() {
        setupObserver()
    }
    
    private func setupObserver() {
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
    
    func addTask(_ task: TaskModel) {
        coreDataManager.saveTask(task)
    }
    
    func updateTask(_ task: TaskModel) {
        coreDataManager.updateTask(task)
    }
    
    func deleteTask(_ task: TaskModel) {
        coreDataManager.deleteTask(task)
    }
}

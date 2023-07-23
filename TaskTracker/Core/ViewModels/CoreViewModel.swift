//
//  TaskListViewModel.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/15.
//

import Foundation
import Combine

class CoreViewModel: ObservableObject {
    @Published var allTasks: [TaskModel] = []
    @Published var allCategories: [String] = ["분류 없음"]
    
    @Published var searchText: String = ""
    @Published var searchBarIsOn: Bool = false
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        
        fetchTasks()
        fetchCategories()
    }
    
    private func fetchTasks() {
        self.allTasks = coreDataManager.taskEntities.map { taskEntity in
            return TaskModel(
                id: taskEntity.id,
                title: taskEntity.title,
                taskDescription: taskEntity.taskDescription,
                deadline: taskEntity.deadline,
                isCompleted: taskEntity.isCompleted,
                category: taskEntity.category
            )
        }
    }
    
    private func fetchCategories() {
        self.allCategories = coreDataManager.categoryEntities.compactMap { categoryEntity in
            return categoryEntity.name
        }
    }
}

// MARK: CRUD methods for task
extension CoreViewModel {
    func saveTask(task: TaskModel) {
        coreDataManager.updateTask(task: task)
        fetchTasks()
    }
    
    func deleteTask(task: TaskModel) {
        coreDataManager.deleteTask(task: task)
        fetchTasks()
    }
}

// MARK: CRUD methods for category
extension CoreViewModel {
    func saveCategory(category: String) {
        coreDataManager.addCategory(category: category)
        fetchCategories()
    }
    
    func removeCategory(category: String) {
        coreDataManager.removeCategory(category: category)
        fetchCategories()
    }
}

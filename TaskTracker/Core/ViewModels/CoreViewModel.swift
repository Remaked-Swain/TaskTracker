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
    @Published var allCategories: [String] = []
    
    @Published var searchText: String = ""
    @Published var searchBarIsOn: Bool = false
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
}

// MARK: CRUD methods for task
extension CoreViewModel {
    func saveTask(task: TaskModel) {
        coreDataManager.updateTask(task: task)
    }
    
    func deleteTask(task: TaskModel) {
        coreDataManager.deleteTask(task: task)
    }
}

// MARK: CRUD methods for category
extension CoreViewModel {
    func saveCategory(category: String) {
        coreDataManager.addCategory(category: category)
    }
    
    func removeCategory(category: String) {
        coreDataManager.removeCategory(category: category)
    }
}

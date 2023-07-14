//
//  TaskListViewModel.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/15.
//

import Foundation

class TaskListViewModel: ObservableObject {
    @Published var allTasks: [TaskModel] = []
    
    private let dataService = DataService.shared
    
    init() {
        fetchTasks()
    }
    
    private func fetchTasks() {
        dataService.fetchTasks { [weak self] tasks in
            DispatchQueue.main.async {
                self?.allTasks = tasks
            }
        }
    }
    
    func addTask(title: String?, taskDescription: String?, deadline: Date?) {
        let task = TaskModel(title: title, taskDescription: taskDescription, deadline: deadline)
        dataService.saveTask(task)
        fetchTasks()
    }
}

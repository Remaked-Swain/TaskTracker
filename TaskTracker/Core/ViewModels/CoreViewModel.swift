//
//  TaskListViewModel.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/15.
//

import Foundation

class CoreViewModel: ObservableObject {
    @Published var allTasks: [TaskModel] = DeveloperPreview.instance.tasks
    
    private let dataService = DataService.shared
    
//    init() {
//        fetchTasks()
//    }
//    
//    private func fetchTasks() {
//        dataService.fetchTasks { [weak self] tasks in
//            DispatchQueue.main.async {
//                self?.allTasks = tasks
//            }
//        }
//    }
//    
//    func addTask(title: String? = nil, taskDescription: String? = nil, deadline: Date? = nil) {
//        let newTask = TaskModel(title: title, taskDescription: taskDescription, deadline: deadline)
//        dataService.saveTask(newTask)
//        fetchTasks()
//    }
//    
//    func updateTask(_ task: TaskModel, title: String?, taskDescription: String?, deadline: Date?) {
//        let updatedTask = TaskModel(
//            id: task.id,
//            title: title ?? task.title,
//            taskDescription: taskDescription ?? task.taskDescription,
//            deadline: deadline ?? task.deadline,
//            isCompleted: task.isCompleted
//        )
//        dataService.updateTask(updatedTask)
//        fetchTasks()
//    }
//    
//    func deleteTask(_ task: TaskModel) {
//        dataService.deleteTask(task)
//        fetchTasks()
//    }
//    
//    func completeTask(_ task: TaskModel) {
//        let updatedTask = TaskModel(
//            id: task.id,
//            title: task.title,
//            taskDescription: task.taskDescription,
//            deadline: task.deadline,
//            isCompleted: !task.isCompleted
//        )
//        dataService.updateTask(updatedTask)
//        fetchTasks()
//    }
}

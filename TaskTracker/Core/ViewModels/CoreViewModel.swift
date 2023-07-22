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
    private var cancellables = Set<AnyCancellable>()
    
    @Published var searchText: String = ""
    @Published var searchBarIsOn: Bool = false
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        
        subscribe()
    }
    
    func subscribe() {
        // taskEntities 의 변화를 감지하여 allTasks 를 업데이트
        $allTasks
            .combineLatest(coreDataManager.$taskEntities)
            .map { (taskModel, taskEntities) -> [TaskModel] in
                taskModel.compactMap { task in
                    guard let taskEntity = taskEntities.first(where: {$0.id == task.id}) else { return nil }
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
            .sink { [weak self] returnedTasks in
                self?.allTasks = returnedTasks
            }
            .store(in: &cancellables)
        
        $allCategories
            .combineLatest(coreDataManager.$categoryEntities)
            .map { (category, categoryEntities) -> [String] in
                category.compactMap { category in
                    guard let categoryEntity = categoryEntities.first(where: {$0.name == category}) else { return nil }
                    return categoryEntity.name
                }
            }
            .sink { [weak self] returnedCategories in
                self?.allCategories = returnedCategories.sorted(by: {$0 < $1})
            }
            .store(in: &cancellables)
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

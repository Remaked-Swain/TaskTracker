//
//  TaskListViewModel.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/15.
//

import Foundation
import Combine

class CoreViewModel: ObservableObject {
    @Published var allTasks: [TaskModel] = DeveloperPreview.instance.tasks
    @Published var allCategories: [String] = ["없음"]
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
}

// MARK: CRUD methods for task
extension CoreViewModel {
    func saveTask(task: TaskModel) {
        // allTasks 에 같은 id를 가진 task 가 있으면 대입업데이트, 아니면 새로이 추가
        guard let index = allTasks.firstIndex(where: {$0.id == task.id}) else {
            allTasks.append(task)
            return
        }
        
        allTasks[index] = task
    }
}

// MARK: CRUD methods for category
extension CoreViewModel {
    func saveCategory(category: String) {
        // 이미 존재하는 카테고리인 경우 무시, 아니면 새로이 추가
        guard allCategories.contains(category) == false else { return }
        allCategories.append(category)
    }
}

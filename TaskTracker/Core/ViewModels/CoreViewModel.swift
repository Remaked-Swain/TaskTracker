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
    
    private let taskDataService: TaskDataService
    private let categoryDataService: CategoryDataService
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        taskDataService = TaskDataService()
        categoryDataService = CategoryDataService()
        
        addSubscriber()
    }
    
    private func addSubscriber() {
        taskDataService.$allTasks
            .receive(on: DispatchQueue.main)
            .assign(to: \.allTasks, on: self)
            .store(in: &cancellables)
        
        categoryDataService.$allCategories
            .receive(on: DispatchQueue.main)
            .assign(to: \.allCategories, on: self)
            .store(in: &cancellables)
    }
    
    // Methods to manage tasks
    func saveTask(task: TaskModel) {
        // 기존 Tasks 중 같은 id 를 가진 할 일이 존재하면 덮어쓰기, 없으면 추가
        if let index = allTasks.firstIndex(where: {$0.id == task.id}) {
            allTasks[index] = task
        } else {
            allTasks.append(task)
        }
    }
    
    func deleteTask(task: TaskModel) {
        
    }

    // Methods to manage categories
    func addCategory(category: String) {
        // 동일한 이름의 카테고리 무한생성 방지,
        guard allCategories.contains(category) == false else { return }
        allCategories.append(category)
    }
}

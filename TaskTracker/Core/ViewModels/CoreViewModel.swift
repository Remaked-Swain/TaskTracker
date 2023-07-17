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
    
    private let dataService = DataService.shared
    private let calendarService = CalendarService.shared
    
    init() {
        
    }
    
    private func loadTasks() {
        
    }
    
    // Methods to manage tasks
    func addTask(task: TaskModel) {
        // 기존 Tasks 중 같은 id 를 가진 할 일이 존재하면 덮어쓰기, 없으면 추가
        guard let index = allTasks.firstIndex(where: {$0.id == task.id}) else {
            allTasks.append(task)
            return
        }
        allTasks[index] = task
    }
    
    // Methods to manage categories
    func addCategory(category: String) {
        // 동일한 이름의 카테고리 무한생성 방지,
        guard allCategories.contains(category) else {
            allCategories.append(category)
            return
        }
    }
}

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

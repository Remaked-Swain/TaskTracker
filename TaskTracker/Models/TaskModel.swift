//
//  TaskModel.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/14.
//

import Foundation

struct TaskModel: Identifiable, Hashable {
    let id: UUID
    let title: String
    let taskDescription: String
    let deadline: Date?
    let isCompleted: Bool
    let category: String?
    
    init(id: UUID = UUID(), title: String? = nil, taskDescription: String? = nil, deadline: Date? = nil, isCompleted: Bool = false, category: String? = nil) {
        self.id = id
        self.title = title ?? "새로운 할 일"
        self.taskDescription = taskDescription ?? ""
        self.deadline = deadline
        self.isCompleted = isCompleted
        self.category = category ?? "없음"
    }
}

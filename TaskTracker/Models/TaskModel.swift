//
//  TaskModel.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/14.
//

import Foundation

struct TaskModel: Identifiable {
    let id: UUID
    let title: String
    let taskDescription: String?
    let deadline: Date?
    let isCompleted: Bool
    
    init(id: UUID = UUID(), title: String? = nil, taskDescription: String? = nil, deadline: Date? = nil, isCompleted: Bool = false) {
        self.id = id
        self.title = title ?? "새로운 할 일"
        self.taskDescription = taskDescription
        self.deadline = deadline
        self.isCompleted = isCompleted
    }
}

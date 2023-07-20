//
//  TaskFormViewModel.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/20.
//

import Foundation

class TaskFormViewModel: ObservableObject {
    @Published var datePickerIsOn: Bool = false
    @Published var datePickerSelection: Date = Date()
    @Published var categoryPickerIsOn: Bool = false
    @Published var categoryPickerSelection: String = "없음"
    @Published var textFieldTitle: String = ""
    @Published var textFieldTaskDescription: String = ""
    @Published var textFieldCategory: String = ""
    
    private var task: (id: UUID?, title: String?, taskDescription: String?, deadline: Date?, isCompleted: Bool, category: String?) = (nil, nil, nil, nil, false, nil)
    
    // computed properties
    var onEditing: Bool {
        textFieldTitle.isEmpty == false || textFieldTaskDescription.isEmpty == false || datePickerIsOn || categoryPickerIsOn
    }
    
    init(task: TaskModel?) {
        // 기존의 task 를 편집할 때는 task 가 전달되고, 새로운 task 를 만들 때는 nil 이 전달되어 이니셜라이징
        guard let task = task else { return }
        
        readyToEditTask(task)
    }
    
    private func readyToEditTask(_ task: TaskModel) {
        self.task = (
            id: task.id,
            title: task.title,
            taskDescription: task.taskDescription,
            deadline: task.deadline,
            isCompleted: task.isCompleted,
            category: task.category
        )
        
        textFieldTitle = task.title
        textFieldTaskDescription = task.taskDescription
        datePickerIsOn = true
        datePickerSelection = task.deadline ?? Date()
        categoryPickerIsOn = true
        categoryPickerSelection = task.category ?? "없음"
    }
}

// MARK: control methods
extension TaskFormViewModel {
    func datePickerToggle() {
        self.datePickerIsOn.toggle()
    }
    
    func categoryPickerToggle() {
        self.categoryPickerIsOn.toggle()
    }
    
    func allClear() {
        textFieldTitle = ""
        textFieldTaskDescription = ""
        datePickerSelection = Date()
        datePickerIsOn = false
        categoryPickerIsOn = false
        categoryPickerSelection = "없음"
    }
    
    func taskIntegrityCheck() -> TaskModel {
        return TaskModel(
            id: self.task.id,
            title: textFieldTitle.isEmpty ? nil : textFieldTitle,
            taskDescription: textFieldTaskDescription.isEmpty ? nil : textFieldTaskDescription,
            deadline: datePickerIsOn ? datePickerSelection : nil,
            isCompleted: self.task.isCompleted,
            category: categoryPickerIsOn ? categoryPickerSelection : nil
        )
    }
    
    func categoryIntegrityCheck() -> String {
        // textFieldCategory 가 비어있으면 기본값 반환, 아니면 작성된 카테고리명 반환
        guard textFieldCategory.isEmpty else { return textFieldCategory }
        return "새로운 카테고리"
    }
}

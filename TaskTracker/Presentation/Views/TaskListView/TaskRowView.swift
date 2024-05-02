//
//  TaskRowView.swift
//  TaskTracker
//
//  Created by Swain Yun on 5/2/24.
//

import SwiftUI

struct TaskRowView: View {
    @State private var isCompleted: Bool
    private let task: TaskModel
    
    init(task: TaskModel) {
        self.task = task
        self._isCompleted = State(wrappedValue: task.isCompleted)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack(spacing: 20) {
                toggleCompletionButton
                taskInformationSector
            }
        }
    }
}

extension TaskRowView {
    private var toggleCompletionButton: some View {
        ZStack {
            Image(systemName: isCompleted ? "checkmark" : "circle.inset.filled")
                .aspectRatio(contentMode: .fill)
                .foregroundStyle(isCompleted ? Color.theme.secondaryColor : Color.theme.accentColor)
                .scaleEffect(isCompleted ? 1 : 2)
                .animation(.spring(), value: isCompleted)
                .onTapGesture {
                    toggleTaskCompletion()
                    updateCompletion()
                }
        }
    }
    
    private var taskInformationSector: some View {
        VStack(alignment: .leading) {
            Text(task.title)
                .font(.headline)
                .foregroundStyle(isCompleted ? Color.theme.secondaryColor : Color.theme.accentColor)
                .fontWeight(.bold)
                .strikethrough(isCompleted)
            
            Text(task.taskDescription)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color.theme.secondaryColor)
                .lineLimit(1)
                .strikethrough(isCompleted)
            
            Text(
        }
    }
    
    private func toggleTaskCompletion() {
        withAnimation(.spring()) {
            isCompleted.toggle()
        }
    }
    
    private func updateCompletion() {
        
    }
}

//
//  TaskRowView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/15.
//

import SwiftUI

struct TaskRowView: View {
    @EnvironmentObject private var coreVM: CoreViewModel
    
    @State private var isCompleted: Bool
    
    let task: TaskModel
    
    init(task: TaskModel) {
        self.task = task
        self._isCompleted = State(wrappedValue: task.isCompleted)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            taskCell
        }
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        TaskRowView(task: dev.tasks.first!)
            .environmentObject(CoreViewModel(coreDataManager: dev.coreDataManager))
    }
}

// MARK: Extracted views
extension TaskRowView {
    private var taskCell: some View {
        HStack(spacing: 20) {
            ZStack {
                Image(systemName: isCompleted ? "checkmark" : "circle.fill")
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(isCompleted ? .secondary : .accentColor)
                    .scaleEffect(isCompleted ? 1.0 : 1.5)
                    .animation(.spring(), value: isCompleted)
                    .onTapGesture {
                        isCompletedToggle()
                    }
            }
            
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                    .foregroundColor(isCompleted ? .secondary : .accentColor)
                    .fontWeight(.bold)
                    .strikethrough(isCompleted)
                
                Text(task.taskDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .strikethrough(isCompleted)
                
                Text(CalendarService.shared.formatDate(task.deadline))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .strikethrough(isCompleted)
            }
        }
        .frame(height: 55)
    }
}

// MARK: Methods
extension TaskRowView {
    private func isCompletedToggle() {
        withAnimation(.spring()) {
            isCompleted.toggle()
        }
    }
}

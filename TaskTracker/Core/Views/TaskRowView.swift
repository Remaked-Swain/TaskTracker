//
//  TaskRowView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/15.
//

import SwiftUI

struct TaskRowView: View {
    @EnvironmentObject private var coreVM: CoreViewModel
    
    let task: TaskModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            taskCell
        }
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        TaskRowView(task: dev.tasks.first!)
            .environmentObject(CoreViewModel())
    }
}

extension TaskRowView {
    private var taskCell: some View {
        HStack {
            ZStack {
                if task.isCompleted {
                    Circle()
                        .foregroundColor(.accentColor)
                        .overlay(
                            Circle()
                                .stroke(
                                    Color.white,
                                    lineWidth: 2
                                )
                                .padding()
                        )
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 8)
                } else {
                    Circle()
                        .stroke(Color.accentColor, lineWidth: 2)
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 8)
                }
            }
            .onTapGesture {
                
            }
            
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .strikethrough(task.isCompleted)
                
                Text(task.taskDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .strikethrough(task.isCompleted)
            }
        }
        .frame(height: 55)
    }
}

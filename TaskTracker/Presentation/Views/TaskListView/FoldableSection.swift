//
//  FoldableSection.swift
//  TaskTracker
//
//  Created by Swain Yun on 5/2/24.
//

import SwiftUI

struct FoldableSection<ViewModel: CoreViewModel>: View {
    @ObservedObject private var viewModel: ViewModel
    @State private var isExpanded: Bool = true
    
    private let tasks: [TaskModel]
    
    init(viewModel: ViewModel, tasks: [TaskModel]) {
        self.viewModel = viewModel
        self.tasks = tasks
    }
    
    var body: some View {
        Section {
            if isExpanded {
                ForEach(tasks) { task in
                    NavigationLink(value: task) {
//                        TaskRowView
                    }
                    .swipeActions {
                        deleteTaskSwipeAction
                    }
                }
            }
        }
    }
}

extension FoldableSection {
    private var deleteTaskSwipeAction: some View {
        Button(role: .destructive) {
            withAnimation(.spring()) {
//                viewModel.deleteTask(task: Task)
            }
        } label: {
            Image(systemName: "trash")
        }
    }
}

//
//  FoldableSection.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/23.
//

import SwiftUI

struct FoldableSection: View {
    @EnvironmentObject private var coreVM: CoreViewModel
    
    @State private var isExpanded: Bool = true
    
    let category: String
    
    init(category: String) {
        self.category = category
    }
    
    var body: some View {
        Section {
            if isExpanded {
                ForEach(coreVM.allTasks.filter {$0.category == category}) { task in
                    NavigationLink(value: task) {
                        TaskRowView(task: task)
                            .environmentObject(coreVM)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            withAnimation(.spring()) {
                                coreVM.deleteTask(task: task)
                            }
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
            }
        } header: {
            FoldableSectionHeader(isExpanded: $isExpanded, text: category)
        }
    }
}

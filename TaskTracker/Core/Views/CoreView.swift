//
//  CoreView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/15.
//

import SwiftUI

struct CoreView: View {
    @StateObject private var coreVM = CoreViewModel()
    
    var body: some View {
        ZStack {
            // Background layer
            Color(.secondarySystemBackground).ignoresSafeArea()
            
            if coreVM.allTasks.isEmpty {
                noTasksText
            } else {
                taskListSection
            }
        }
        .navigationTitle("Task Tracker")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    // menu
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.headline)
                }
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                HStack {
                    // searchbar
                    Button {
                        // search
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.headline)
                    }
                    
                    // taskFormView nav
                    NavigationLink {
                        TaskFormView(task: nil)
                            .environmentObject(coreVM)
                    } label: {
                        Image(systemName: "plus")
                            .font(.headline)
                    }
                }
            }
        }
        .navigationDestination(for: TaskModel.self) { task in
            TaskFormView(task: task)
        }
    }
}

struct CoreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CoreView()
        }
    }
}

extension CoreView {
    private var noTasksText: some View {
        VStack(spacing: 10) {
            Text("일정 목록이 비어있습니다.")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("할 일을 추가해보세요!")
                .font(.subheadline)
        }
        .foregroundColor(.secondary)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var taskListSection: some View {
        List {
            Section {
                ForEach(coreVM.allTasks) { task in
                    TaskRowView(task: task)
                        .environmentObject(coreVM)
                }
            } header: {
                Text("Tasks")
            }
        }
    }
}

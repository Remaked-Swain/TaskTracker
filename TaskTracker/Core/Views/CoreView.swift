//
//  CoreViewTmp.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/23.
//

import SwiftUI

struct CoreView: View {
    @StateObject private var coreVM: CoreViewModel = CoreViewModel(coreDataManager: CoreDataManager.shared)

    var body: some View {
        ZStack {
            // Background Layer
            Color(.secondarySystemBackground).ignoresSafeArea()

            VStack {
                if coreVM.allTasks.isEmpty {
                    noTasksText
                } else {
                    categorizedList
                }
            }
        }
        .navigationTitle("Task Tracker")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    menuViewIsOnToggle()
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.headline)
                }
            }

            ToolbarItemGroup(placement: .navigationBarTrailing) {
                HStack {
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
                .environmentObject(coreVM)
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

// MARK: Extracted views
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

    private var categorizedList: some View {
        List {
            ForEach(coreVM.allCategories, id: \.self) { categoryName in
                if coreVM.allTasks.filter({$0.category == categoryName}).isEmpty == false {
                    FoldableSection(category: categoryName)
                        .environmentObject(coreVM)
                }
            }
        }
    }
}

// MARK: Methods
extension CoreView {
    private func menuViewIsOnToggle() {
        withAnimation(.easeInOut) {
            coreVM.menuViewIsOn.toggle()
        }
    }
}

//
//  CoreViewTmp.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/23.
//

import SwiftUI

struct CoreView: View {
    @EnvironmentObject private var coreVM: CoreViewModel
    @Binding var isPresentedMenu: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                if coreVM.allTasks.isEmpty {
                    noTasksText
                } else {
                    categorizedList
                }
            }
            .navigationTitle(Stage.core.id)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation(.spring()) {
                            isPresentedMenu.toggle()
                        }
                    } label: {
                        Image(systemName: isPresentedMenu ? "xmark" : "line.3.horizontal")
                            .font(.headline)
                            .imageScale(.large)
                            .opacity(isPresentedMenu ? 0 : 1)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        TaskFormView(task: nil)
                            .environmentObject(coreVM)
                    } label: {
                        Image(systemName: "plus")
                            .font(.headline)
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

struct CoreView_Previews: PreviewProvider {
    static var previews: some View {
        CoreView(isPresentedMenu: .constant(false))
            .environmentObject(CoreViewModel(coreDataManager: CoreDataManager.shared))
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
        .navigationDestination(for: TaskModel.self) { task in
            TaskFormView(task: task)
                .environmentObject(coreVM)
        }
    }
}

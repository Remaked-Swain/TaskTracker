//
//  TaskListView.swift
//  TaskTracker
//
//  Created by Swain Yun on 5/1/24.
//

import SwiftUI

struct TaskListView<ViewModel: CoreViewModel>: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
            }
        }
        .navigationTitle(viewModel.selectedStage.title)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                menuButton
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                pushTaskFormViewButton
            }
        }
    }
}

extension TaskListView {
    private var noTasksTextView: some View {
        VStack(spacing: 10) {
            Text("일정 목록이 비어있습니다.")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("할 일을 추가해보세요!")
                .font(.subheadline)
        }
        .foregroundStyle(Color.theme.secondaryColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var categorizedList: some View {
        List(viewModel.allCategories, id: \.self) { category in
            if viewModel.filterTasks(by: category).isEmpty == false {
                FoldableSection(viewModel: viewModel, category: category)
            }
        }
    }
    
    private var menuButton: some View {
        Button {
            withAnimation(.spring()) {
                viewModel.toggleMenu()
            }
        } label: {
            Image(systemName: viewModel.isMenuPresented ? "xmark" : "line.3.horizontal")
                .font(.headline)
                .imageScale(.large)
                .opacity(viewModel.isMenuPresented ? 0 : 1)
        }
    }
    
    private var pushTaskFormViewButton: some View {
        NavigationLink {
            // taskformview
        } label: {
            Image(systemName: "plus")
                .font(.headline)
                .imageScale(.large)
        }
    }
}

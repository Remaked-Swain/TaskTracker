//
//  CoreView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/15.
//

import SwiftUI

struct CoreView: View {
    @StateObject private var coreVM = CoreViewModel()
    
    @State private var isPresentedTaskFormView: Bool = false
    
    var body: some View {
        ZStack {
            // Background layer
            Color(.secondarySystemBackground).ignoresSafeArea()
            
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
            .navigationTitle("Task Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // menu
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        // searchbar
                        
                        Button {
                            // search
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                }
            }
            
            if isPresentedTaskFormView {
                TaskFormView()
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .trailing)
                        )
                    )
            }
            
            addTaskButton
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
    private var addTaskButton: some View {
        // Buttons
        HStack {
            Button {
                withAnimation(.linear) {
                    isPresentedTaskFormView.toggle()
                }
            } label: {
                Image(systemName: isPresentedTaskFormView ? "xmark" : "plus")
                    .imageScale(.large)
                    .font(.title)
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                    .shadow(radius: 10, y: 10)
                    .background(
                        Circle()
                            .foregroundColor(isPresentedTaskFormView ? .secondary : .accentColor)
                            .shadow(radius: 10, y: 10)
                    )
                    .animation(nil, value: isPresentedTaskFormView)
            }
        }
        .padding(.horizontal)
    }
    
    private var noTasksText: some View {
        Text("할 일을 추가해보세요!")
            .font(.title3)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

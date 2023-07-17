//
//  TaskFormView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/16.
//

import SwiftUI

struct TaskFormView: View {
    @State private var title: String
    @State private var taskDescription: String
    @State private var deadline: Date?
    
    @State private var datePickerIsOn: Bool = false
    @State private var datePickerSelection: Date = Date()
    
    // 기존의 task 를 편집할 때는 task 가 전달되고, 새로운 task 를 만들 때는 nil 이 전달되어 이니셜라이징됨
    init(task: TaskModel?) {
        if let task = task {
            self._title = State(initialValue: task.title)
            self._taskDescription = State(initialValue: task.taskDescription)
            self._deadline = State(initialValue: task.deadline)
            self.datePickerSelection = task.deadline ?? Date()
        } else {
            self._title = State(initialValue: "")
            self._taskDescription = State(initialValue: "")
            self._deadline = State(initialValue: nil)
        }
    }
    
    var body: some View {
        ScrollView {
            TextField("제목", text: $title)
                .autoCorrectionDisabledTextField()
                .padding()
                .secondarySystemBackgroundModifier()
            
            TextField("할 일에 대한 설명", text: $taskDescription)
                .autoCorrectionDisabledTextField()
                .padding()
                .secondarySystemBackgroundModifier()
            
            datePickerSection
                .secondarySystemBackgroundModifier()
        }
        .navigationTitle("할 일 편집")
        .padding()
    }
}

struct TaskFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TaskFormView(task: dev.tasks.first!)
        }
    }
}

extension TaskFormView {
    private var controlButtons: some View {
        // Buttons
        Button {
            withAnimation(.linear) {
                
            }
        } label: {
            Image(systemName: "plus")
                .imageScale(.large)
                .font(.title)
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .shadow(radius: 10, y: 10)
                .background(
                    Circle()
                        .foregroundColor(.accentColor)
                        .shadow(radius: 10, y: 10)
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding(.horizontal)
    }
    
    private var datePickerSection: some View {
        VStack {
            HStack {
                Image(systemName: "calendar")
                    .imageScale(.large)
                    .foregroundColor(datePickerIsOn ? .accentColor : .secondary)
                
                Spacer()
                
                Button {
                    withAnimation(.linear) {
                        datePickerIsOn.toggle()
                    }
                } label: {
                    Text(datePickerIsOn ? "닫기" : "열기")
                        .foregroundColor(.accentColor)
                }

            }
            
            if datePickerIsOn {
                DatePicker(selection: $datePickerSelection) {
                    Text("마감기한")
                }
                .datePickerStyle(.graphical)
            }
        }
        .padding()
    }
}

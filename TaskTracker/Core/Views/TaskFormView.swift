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
    
    // 기존의 task 를 편집할 때
    init(task: TaskModel) {
        self._title = State(initialValue: task.title)
        self._taskDescription = State(initialValue: task.taskDescription)
        self._deadline = State(initialValue: task.deadline)
        self.datePickerSelection = task.deadline ?? Date()
    }
    
    // 새로운 task 를 생성할 때
    init() {
        self._title = State(initialValue: "")
        self._taskDescription = State(initialValue: "")
        self._deadline = State(initialValue: nil)
    }
    
    var body: some View {
        VStack {
            TextField("제목", text: $title)
                .padding()
            
            TextField("할 일에 대한 설명", text: $taskDescription)
                .padding()
            
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
                    .transition(.push(from: .top))
                }
            }
            .padding()
        }
        .secondarySystemBackgroundModifier()
    }
}

struct TaskFormView_Previews: PreviewProvider {
    static var previews: some View {
        TaskFormView()
            .padding()
    }
}

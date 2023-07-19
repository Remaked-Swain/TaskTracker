//
//  TaskFormView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/16.
//

import SwiftUI

struct TaskFormView: View {
    @EnvironmentObject private var coreVM: CoreViewModel
    @State private var task: TaskModel
    @State private var id: UUID
    @State private var title: String
    @State private var taskDescription: String
    @State private var deadline: Date?
    @State private var category: String?
    
    @State private var datePickerIsOn: Bool = false
    @State private var datePickerSelection: Date = Date()
    @State private var categoryPickerIsOn: Bool = false
    @State private var categoryPickerSelection: String = "없음"
    
    @State private var tmpCategory: String = ""
    
    // 기존의 task 를 편집할 때는 task 가 전달되고, 새로운 task 를 만들 때는 nil 이 전달되어 이니셜라이징됨
    init(task: TaskModel?) {
        if let task = task {
            self._task = State(initialValue: task)
            self._id = State(initialValue: task.id)
            self._title = State(initialValue: task.title)
            self._taskDescription = State(initialValue: task.taskDescription)
            self._deadline = State(initialValue: task.deadline)
            self.datePickerSelection = task.deadline ?? Date()
            self._category = State(initialValue: task.category)
            self.categoryPickerSelection = task.category ?? ""
        } else {
            self._task = State(initialValue: TaskModel())
            self._id = State(initialValue: UUID())
            self._title = State(initialValue: "")
            self._taskDescription = State(initialValue: "")
            self._deadline = State(initialValue: nil)
            self._category = State(initialValue: nil)
        }
    }
    
    var body: some View {
        ZStack {
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
                
                categoryPickerSection
                    .secondarySystemBackgroundModifier()
            }
            
            controlButtons
        }
        .navigationTitle("할 일 편집")
        .padding()
    }
}

struct TaskFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TaskFormView(task: dev.tasks.first!)
                .environmentObject(CoreViewModel())
        }
    }
}

extension TaskFormView {
    private var controlButtons: some View {
        // Buttons
        HStack {
            if title.isEmpty == false || taskDescription.isEmpty == false || datePickerIsOn || categoryPickerIsOn {
                Button {
                    allClear()
                } label: {
                    Image(systemName: "gobackward")
                        .imageScale(.large)
                        .font(.title)
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                        .shadow(radius: 10, y: 10)
                        .background(
                            Circle()
                                .foregroundColor(.secondary)
                                .shadow(radius: 10, y: 10)
                        )
                }
            }
            
            Button {
                withAnimation(.linear) {
                    saveTask()
                }
            } label: {
                Image(systemName: "checkmark")
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(.horizontal)
    }
    
    private var datePickerSection: some View {
        VStack {
            HStack {
                Image(systemName: "calendar")
                    .imageScale(.large)
                    .fontWeight(.semibold)
                    .foregroundColor(datePickerIsOn ? .accentColor : .secondary)
                
                Text("마감기한")
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .imageScale(.large)
                    .fontWeight(.semibold)
                    .rotationEffect(Angle(degrees: datePickerIsOn ? 180 : 0))
                    .foregroundColor(.accentColor)
            }
            .onTapGesture {
                withAnimation(.easeInOut) {
                    datePickerIsOn.toggle()
                }
            }
            
            if datePickerIsOn {
                DatePicker(selection: $datePickerSelection) {
                    Text("마감기한")
                }
                .datePickerStyle(.graphical)
                .tint(Color.accentColor)
            }
        }
        .padding()
    }
    
    private var categoryPickerSection: some View {
        VStack {
            HStack {
                Image(systemName: "folder")
                    .imageScale(.large)
                    .fontWeight(.semibold)
                    .foregroundColor(categoryPickerIsOn ? .accentColor : .secondary)
                
                Text("카테고리")
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .imageScale(.large)
                    .fontWeight(.semibold)
                    .rotationEffect(Angle(degrees: categoryPickerIsOn ? 180 : 0))
                    .foregroundColor(.accentColor)
            }
            .onTapGesture {
                withAnimation(.easeInOut) {
                    categoryPickerIsOn.toggle()
                }
            }
            
            if categoryPickerIsOn {
                Picker(selection: $categoryPickerSelection) {
                    ForEach(coreVM.allCategories, id: \.self) { selectableCategory in
                        Text(selectableCategory)
                    }
                } label: {
                    Text("카테고리")
                }
                .pickerStyle(.inline)
                
                HStack {
                    TextField("새로운 카테고리", text: $tmpCategory)
                        .autoCorrectionDisabledTextField()
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                        )
                    
                    Button {
                        addNewCategory()
                    } label: {
                        Text("+")
                            .font(.title.weight(.semibold))
                            .frame(width: 40)
                            .frame(maxHeight: .infinity)
                            .foregroundColor(.white)
                            .background(Color.accentColor.cornerRadius(10))
                    }
                }
            }
        }
        .padding()
    }
    
    private func allClear() {
        withAnimation(.easeInOut) {
            title = ""
            taskDescription = ""
            datePickerSelection = Date()
            datePickerIsOn = false
            categoryPickerIsOn = false
            categoryPickerSelection = "없음"
            tmpCategory = ""
        }
    }
    
    private func addNewCategory() {
        guard tmpCategory.isEmpty else {
            coreVM.addCategory(category: tmpCategory)
            return
        }
        
        coreVM.addCategory(category: "새로운 카테고리")
    }
    
    private func saveTask() {
        // Integrity check
        // 1. datePicker check
        // 2. category check
        if datePickerIsOn == false {
            deadline = nil
        } else {
            deadline = datePickerSelection
        }
        
        if categoryPickerIsOn == false {
            category = nil
        } else {
            category = categoryPickerSelection
        }

        self.task = TaskModel(
            id: id,
            title: title,
            taskDescription: taskDescription,
            deadline: deadline,
            category: category
        )
        
        coreVM.saveTask(task: task)
    }
}

//
//  TaskFormView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/16.
//

import SwiftUI

struct TaskFormView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var coreVM: CoreViewModel
    
    @State private var tmpTask: TaskModel
    @State private var tmpID: UUID
    @State private var tmpTitle: String?
    @State private var tmpTaskDescription: String?
    @State private var tmpDeadline: Date?
    @State private var tmpCategory: String?
    
    @State private var datePickerIsOn: Bool = false
    @State private var datePickerSelection: Date = Date()
    @State private var categoryPickerIsOn: Bool = false
    @State private var categoryPickerSelection: String = "없음"
    
    @State private var textFieldTitle: String = ""
    @State private var textFieldTaskDescription: String = ""
    @State private var textFieldCategory: String = ""
    
    // 기존의 task 를 편집할 때는 task 가 전달되고, 새로운 task 를 만들 때는 nil 이 전달되어 이니셜라이징됨
    init(task: TaskModel?) {
        if let task = task {
            self._tmpTask = State(initialValue: task)
            self._tmpID = State(initialValue: task.id)
            self._tmpTitle = State(initialValue: task.title)
            self._tmpTaskDescription = State(initialValue: task.taskDescription)
            self._tmpDeadline = State(initialValue: task.deadline)
            self.datePickerSelection = task.deadline ?? Date()
            self._tmpCategory = State(initialValue: task.category)
            self.categoryPickerSelection = task.category ?? ""
        } else {
            self._tmpTask = State(initialValue: TaskModel())
            self._tmpID = State(initialValue: UUID())
            self._tmpTitle = State(initialValue: nil)
            self._tmpTaskDescription = State(initialValue: nil)
            self._tmpDeadline = State(initialValue: nil)
            self._tmpCategory = State(initialValue: nil)
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                TextField("제목", text: $textFieldTitle)
                    .autoCorrectionDisabledTextField()
                    .padding()
                    .secondarySystemBackgroundModifier()
                
                TextField("할 일에 대한 설명", text: $textFieldTaskDescription)
                    .autoCorrectionDisabledTextField()
                    .padding()
                    .secondarySystemBackgroundModifier()
                
                datePickerSection
                    .secondarySystemBackgroundModifier()
                
                categoryPickerSection
                    .secondarySystemBackgroundModifier()
                
                controlButtons
            }
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
                    TextField("새로운 카테고리", text: $textFieldCategory)
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
    
    private var controlButtons: some View {
        HStack {
            if textFieldTitle.isEmpty == false || textFieldTaskDescription.isEmpty == false || datePickerIsOn || categoryPickerIsOn {
                Button {
                    allClear()
                } label: {
                    Text("재설정")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .foregroundColor(.white)
                        .background(Color.secondary.cornerRadius(10))
                }
            }
            
            Button {
                saveTask()
            } label: {
                Text("완료")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .foregroundColor(.white)
                    .background(Color.accentColor.cornerRadius(10))
            }

        }
        .frame(maxWidth: .infinity)
        .shadow(radius: 10, y: 10)
    }
    
    private func allClear() {
        withAnimation(.easeInOut) {
            textFieldTitle = ""
            textFieldTaskDescription = ""
            datePickerSelection = Date()
            datePickerIsOn = false
            categoryPickerIsOn = false
            categoryPickerSelection = "없음"
        }
    }
    
    private func addNewCategory() {
        guard textFieldCategory.isEmpty else {
            coreVM.createCategory(category: textFieldCategory)
            return
        }
        
        coreVM.createCategory(category: "새로운 카테고리")
    }
    
    private func saveTask() {
        // Integrity check
        // 1. datePicker check
        // 2. category check
        if datePickerIsOn == false {
            tmpDeadline = nil
        } else {
            tmpDeadline = datePickerSelection
        }
        
        if categoryPickerIsOn == false {
            tmpCategory = nil
        } else {
            tmpCategory = categoryPickerSelection
        }

        self.tmpTask = TaskModel(
            id: tmpID,
            title: tmpTitle,
            taskDescription: tmpTaskDescription,
            deadline: tmpDeadline,
            category: tmpCategory
        )
        
        coreVM.saveTask(task: tmpTask)
        
        dismiss()
    }
}

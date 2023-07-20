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
    
    @StateObject private var taskFormVM: TaskFormViewModel
    @FocusState private var textFieldFocused: TextFieldInFocus?
    
    init(task: TaskModel?) {
        _taskFormVM = StateObject(wrappedValue: TaskFormViewModel(task: task))
    }
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    TextField("제목", text: $taskFormVM.textFieldTitle)
                        .focused($textFieldFocused, equals: .title)
                        .autoCorrectionDisabledTextField()
                        .padding()
                        .secondarySystemBackgroundModifier()
                    
                    TextField("할 일에 대한 설명", text: $taskFormVM.textFieldTaskDescription)
                        .focused($textFieldFocused, equals: .taskDescription)
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
        }
        .padding()
        .navigationTitle("할 일 편집")
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    previousFocus()
                } label: {
                    Image(systemName: "chevron.up")
                }
                .disabled(hasReachedFirst)
                
                Button {
                    nextFocus()
                } label: {
                    Image(systemName: "chevron.down")
                }
                .disabled(hasReachedLast)
            }
        }
        .onAppear {
            textFieldFocused = .title
        }
        .onTapGesture {
            textFieldFocused = nil
        }
    }
}

struct TaskFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TaskFormView(task: dev.tasks.first!)
                .environmentObject(CoreViewModel(coreDataManager: dev.coreDataManager))
        }
    }
}

private extension TaskFormView {
    @frozen enum TextFieldInFocus: Int, Hashable, CaseIterable {
        case title
        case taskDescription
    }
    
    var hasReachedFirst: Bool {
        self.textFieldFocused == TextFieldInFocus.allCases.first
    }
    
    var hasReachedLast: Bool {
        self.textFieldFocused == TextFieldInFocus.allCases.last
    }
    
    func nextFocus() {
        guard
            let currentFocusStateIndex = textFieldFocused?.rawValue,
            let lastIndex = TextFieldInFocus.allCases.last?.rawValue
        else { return }
        
        let index = min(currentFocusStateIndex + 1, lastIndex)
        self.textFieldFocused = TextFieldInFocus(rawValue: index)
    }
    
    func previousFocus() {
        guard
            let currentFocusStateIndex = textFieldFocused?.rawValue,
            let firstIndex = TextFieldInFocus.allCases.first?.rawValue
        else { return }
        
        let index = max(currentFocusStateIndex - 1, firstIndex)
        self.textFieldFocused = TextFieldInFocus(rawValue: index)
    }
}

extension TaskFormView {
    private var datePickerSection: some View {
        VStack {
            HStack {
                Image(systemName: "calendar")
                    .imageScale(.large)
                    .fontWeight(.semibold)
                    .foregroundColor(taskFormVM.datePickerIsOn ? .accentColor : .secondary)
                
                Text("마감기한")
                
                Spacer()
                
                Image(systemName: "chevron.up")
                    .fontWeight(.semibold)
                    .rotationEffect(Angle(degrees: taskFormVM.datePickerIsOn ? 0 : 180))
                    .foregroundColor(.accentColor)
            }
            .onTapGesture {
                withAnimation(.easeInOut) {
                    taskFormVM.datePickerToggle()
                }
            }
            
            if taskFormVM.datePickerIsOn {
                DatePicker(selection: $taskFormVM.datePickerSelection) {
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
                    .foregroundColor(taskFormVM.categoryPickerIsOn ? .accentColor : .secondary)
                
                Text("카테고리")
                
                Spacer()
                
                Image(systemName: "chevron.up")
                    .fontWeight(.semibold)
                    .rotationEffect(Angle(degrees: taskFormVM.categoryPickerIsOn ? 0 : 180))
                    .foregroundColor(.accentColor)
            }
            .onTapGesture {
                withAnimation(.easeInOut) {
                    taskFormVM.categoryPickerToggle()
                }
            }
            
            if taskFormVM.categoryPickerIsOn {
                Picker(selection: $taskFormVM.categoryPickerSelection) {
                    ForEach(coreVM.allCategories, id: \.self) { selectableCategory in
                        Text(selectableCategory)
                    }
                } label: {
                    Text("카테고리")
                }
                .pickerStyle(.inline)
                
                HStack {
                    TextField("새로운 카테고리", text: $taskFormVM.textFieldCategory)
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
            if taskFormVM.onEditing {
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
        .shadow(radius: 10, y: 20)
    }
    
    private func allClear() {
        withAnimation(.easeInOut) {
            taskFormVM.allClear()
        }
    }
    
    private func saveTask() {
        let tmpTask = taskFormVM.taskIntegrityCheck()
        coreVM.saveTask(task: tmpTask)
        dismiss()
    }
    
    private func addNewCategory() {
        let tmpCategory = taskFormVM.categoryIntegrityCheck()
        coreVM.saveCategory(category: tmpCategory)
        taskFormVM.textFieldCategory = ""
    }
}

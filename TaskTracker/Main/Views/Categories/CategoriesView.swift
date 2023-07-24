//
//  CategoriesView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/24.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject private var coreVM: CoreViewModel
    @State private var textFieldText: String = ""
    @State private var selectedCategory: String = ""
    @Binding var isPresentedMenu: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(coreVM.allCategories, id: \.self) { category in
                        HStack {
                            Text(category)
                                .font(.headline)
                            
                            Spacer()
                            
                            HStack {
                                Text("\(coreVM.allTasks.filter {$0.category == category && $0.isCompleted == true}.count)")
                                Text("/")
                                Text("\(coreVM.allTasks.filter({$0.category == category}).count)")
                            }
                            .font(.callout)
                            .foregroundColor(.secondary)
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation(.spring()) {
                                    coreVM.removeCategory(category: category)
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
                
                HStack {
                    TextField("새로운 카테고리", text: $textFieldText)
                        .autoCorrectionDisabledTextField()
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                        )
                    
                    Button {
                        withAnimation(.spring()) {
                            coreVM.saveCategory(category: textFieldText)
                            textFieldText.removeAll()
                        }
                    } label: {
                        Image(systemName: "plus")
                            .font(.headline)
                            .imageScale(.large)
                            .padding()
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                            )
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding()
            }
            .navigationTitle(Stage.categories.id)
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
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(isPresentedMenu: .constant(false))
            .environmentObject(CoreViewModel(coreDataManager: CoreDataManager.shared))
    }
}

//
//  CategoriesView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/24.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject private var stagingVM: StagingViewModel
    
    private var coreVM: CoreViewModel {
        stagingVM.coreVM
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if coreVM.allCategories.isEmpty {
                    noCategoriesText
                } else {
                    VStack {
                        ForEach(coreVM.allCategories, id: \.self) { category in
                            Text(category)
                        }
                    }
                }
            }
            .navigationTitle(Stage.categories.id)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation(.spring()) {
                            stagingVM.isPresentedMenu.toggle()
                        }
                    } label: {
                        Image(systemName: stagingVM.isPresentedMenu ? "xmark" : "line.3.horizontal")
                            .font(.headline)
                            .imageScale(.large)
                            .opacity(stagingVM.isPresentedMenu ? 0 : 1)
                    }
                }
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
            .environmentObject(StagingViewModel(coreVM: CoreViewModel(coreDataManager: CoreDataManager.shared)))
    }
}

extension CategoriesView {
    private var noCategoriesText: some View {
        VStack(spacing: 10) {
            Text("카테고리를 지정해 할 일을 분류할 수 있습니다.")
                .font(.headline)
                .fontWeight(.bold)

            Text("카테고리를 추가해보세요!")
                .font(.subheadline)
        }
        .foregroundColor(.secondary)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

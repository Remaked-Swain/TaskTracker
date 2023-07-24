//
//  CategoriesView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/24.
//

import SwiftUI

struct CategoriesView: View {
    var body: some View {
        NavigationStack {
            Text("Categories")
                .navigationTitle(Stage.categories.id)
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}

//
//  SearchBarView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/21.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? .secondary : .accentColor)
            
            TextField(text: $searchText) {
                Text("제목으로 검색")
            }
            
            if searchText.isEmpty == false {
                Image(systemName: "xmark")
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        clearSearchText()
                    }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground).cornerRadius(10))
    }
    
    private func clearSearchText() {
        withAnimation(.easeInOut) {
            searchText.removeAll()
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
            .padding()
    }
}

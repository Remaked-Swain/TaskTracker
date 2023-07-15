//
//  CoreView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/15.
//

import SwiftUI

struct CoreView: View {
    @StateObject private var coreVM = CoreViewModel()
    
    var body: some View {
        ZStack {
            // Background layer
            Color(.secondarySystemBackground).ignoresSafeArea()
            
            VStack {
                headerButtons
                
                navigationTitleSection
                
                // Categories section
//                Section {
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        LazyHStack {
//                            ForEach(0..<10) { _ in
//                                Text("카테고리별!!!")
//                            }
//                        }
//                    }
//                    .frame(height: 200)
//                } header: {
//                    Text("Categories")
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.horizontal)
                
                // filtered tasks list section
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyVStack {
                            ForEach(0..<10) { _ in
                                Text("카테고리별!!!")
                            }
                        }
                    }
                    .frame(height: 200)
                } header: {
                    Text("All Tasks")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                Spacer()
            }
            
            // Button
            Button {
                // add task
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
    private var headerButtons: some View {
        // header section
        HStack {
            Button {
                // menu
            } label: {
                Image(systemName: "line.3.horizontal")
            }

            Spacer()
            
            Button {
                // search
            } label: {
                Image(systemName: "magnifyingglass")
            }
        }
        .tint(.accentColor)
        .imageScale(.large)
        .font(.headline)
        .padding(.top)
        .padding(.horizontal)
    }
    
    private var navigationTitleSection: some View {
        HStack {
            Text("Task Tracker")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
        }
        .padding()
    }
}

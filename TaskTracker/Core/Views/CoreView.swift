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
                
                HStack {
                    Text("Task Tracker")
                        .font(.largeTitle)
                }
                
                Spacer()
                
                // Categories section
                
                // filtered tasks list section
                
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
}

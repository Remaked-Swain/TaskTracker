//
//  CoreView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/15.
//

import SwiftUI

struct StagingView: View {
    @StateObject private var stagingVM: StagingViewModel = StagingViewModel()
    @Namespace var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            // Background Layer
            Color(.secondarySystemBackground)
                .ignoresSafeArea()
            
            sideMenu
            
            ZStack {
                StageTab()
                    .cornerRadius(stagingVM.isPresentedMenu ? 20 : 0)
                    .scaleEffect(stagingVM.isPresentedMenu ? 0.84 : 1)
                    .offset(x: stagingVM.isPresentedMenu ? getRect().width - 120 : 0)
                    .ignoresSafeArea()
                    .overlay(
                        Button {
                            withAnimation(.spring()) {
                                stagingVM.isPresentedMenu.toggle()
                            }
                        } label: {
                            Image(systemName: stagingVM.isPresentedMenu ? "xmark" : "line.3.horizontal")
                                .font(.headline)
                                .padding()
                        }
                        ,alignment: .topLeading
                    )
                    .environmentObject(StagingViewModel())
            }
        }
    }
}

struct StagingView_Previews: PreviewProvider {
    static var previews: some View {
        StagingView()
    }
}

extension StagingView {
    private var sideMenu: some View {
        // Side Menu
        VStack(alignment: .leading, spacing: 30) {
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                // Profile picture
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray.opacity(0.3))
                    .padding(.top)
                
                Spacer()
                
                // Destinations
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(stagingVM.stages) { stage in
                        StageButton(stage: stage, animation: animation)
                            .environmentObject(stagingVM)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct Categories: View {
    var body: some View {
        NavigationStack {
            Text("Categories")
                .navigationTitle(Stage.categories.id)
        }
    }
}

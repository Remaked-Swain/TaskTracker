//
//  CoreView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/15.
//

import SwiftUI

struct StagingView: View {
    @StateObject private var stagingVM: StagingViewModel = StagingViewModel()
    @StateObject private var coreVM: CoreViewModel = CoreViewModel(coreDataManager: CoreDataManager.shared)
    @Namespace var animation
    
    var body: some View {
        ZStack {
            // Background Layer
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                sideMenu
            }
            
            stageTabArea
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
                HStack(spacing: 30) {
                    // Profile picture
                    ZStack(alignment: .center) {
                        ProgressCircle(totalTasksCount: coreVM.allTasks.count, completedTasksCount: coreVM.allTasks.filter({$0.isCompleted == true}).count)
                            .frame(width: 100, height: 100)
                        
                        Image("dev-jeans")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    }
                    
                    // Go back to stage
                    Button {
                        withAnimation(.spring()) {
                            stagingVM.isPresentedMenu.toggle()
                        }
                    } label: {
                        VStack {
                            Image(systemName: "arrow.right.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                            Text("돌아가기")
                                .font(.headline)
                        }
                    }
                }
                
                // Stages
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
    
    private var stageTabArea: some View {
        ZStack {
            // Two Background Layers
            Color.theme.backgroundColor
                .opacity(0.5)
                .cornerRadius(stagingVM.isPresentedMenu ? 45 : 0)
                .shadow(color: .black.opacity(0.07), radius: 5, x: -10, y: 0)
                .offset(x: stagingVM.isPresentedMenu ? -25 : 0)
                .padding(.vertical, 30)
            
            Color.theme.backgroundColor
                .opacity(0.4)
                .cornerRadius(stagingVM.isPresentedMenu ? 45 : 0)
                .shadow(color: .black.opacity(0.07), radius: 5, x: -10, y: 0)
                .offset(x: stagingVM.isPresentedMenu ? -50 : 0)
                .padding(.vertical, 60)
            
            StageTab()
                .cornerRadius(stagingVM.isPresentedMenu ? 45 : 0)
        }
        .environmentObject(stagingVM)
        .environmentObject(coreVM)
        .scaleEffect(stagingVM.isPresentedMenu ? 0.84 : 1)
        .offset(x: stagingVM.isPresentedMenu ? getRect().width - 120 : 0)
        .ignoresSafeArea()
    }
}

//
//  StagingView.swift
//  TaskTracker
//
//  Created by Swain Yun on 3/30/24.
//

import SwiftUI

struct StagingView<ViewModel: CoreViewModel>: View {
    @ObservedObject private var viewModel: ViewModel
    @Namespace var animation
    @State private var selectedStage: StageType = .core
    @State private var isMenuPresented: Bool = false
    
    init(fetchTasksCompletionRateUseCase: FetchTasksCompletionRateUseCase) {
        self._coreViewModel = ObservedObject(wrappedValue: DefaultCoreViewModel(fetchTasksCompletionRateUseCase: fetchTasksCompletionRateUseCase))
    }
    
    var body: some View {
        ZStack {
            background
            
            ScrollView {
                sideMenu
            }.scrollIndicators(.hidden)
            
            stageTabArea
        }
    }
}

#Preview {
    StagingView(fetchTasksCompletionRateUseCase: DefaultFetchTasksCompletionRateUseCase(taskListRepository: DefaultTaskListRepository()))
}

extension StagingView {
    private var background: some View {
        Color.theme.backgroundColor
            .ignoresSafeArea()
    }
    
    private var sideMenu: some View {
        // Side Menu
        VStack(alignment: .leading, spacing: 30) {
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 30) {
                    profilePicture
                    turnBackButton
                }
                
                stageButtonsArea
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:.topLeading)
    }
    
    private var profilePicture: some View {
        ZStack(alignment: .center) {
            ProgressCircleView(progress: $coreViewModel.tasksCompletionRate)
                .frame(width: 100, height: 100)
            
            Image("dev-jeans")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
        }
    }
    
    private var turnBackButton: some View {
        Button {
            withAnimation(.spring()) {
                isMenuPresented.toggle()
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
    
    private var stageButtonsArea: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(coreViewModel.selectableStages) { stage in
                StageButton(selectedStage: $selectedStage, stage: stage, animation: animation)
            }
        }
    }
    
    private var stageTabArea: some View {
        ZStack {
            Color.theme.backgroundColor
                .opacity(0.5)
                .clipShape(RoundedRectangle(cornerRadius: isMenuPresented ? 45 : 0))
                .shadow(color: .black.opacity(0.07), radius: 5, x: -10, y: 0)
                .offset(x: isMenuPresented ? -25 : 0)
                .padding(.vertical, 30)
            
            Color.theme.backgroundColor
                .opacity(0.4)
                .clipShape(RoundedRectangle(cornerRadius: isMenuPresented ? 45 : 0))
                .shadow(color: .black.opacity(0.07), radius: 5, x: -10, y: 0)
                .offset(x: isMenuPresented ? -50 : 0)
                .padding(.vertical, 60)
            
            StageTab(isMenuPresented: $isMenuPresented, selectedStage: $selectedStage)
                .clipShape(RoundedRectangle(cornerRadius: isMenuPresented ? 45 : 0))
        }
        .environmentObject(coreViewModel)
        .scaleEffect(isMenuPresented ? 0.04 : 1)
        .offset(x: isMenuPresented ? rect.width - 120 : 0)
        .ignoresSafeArea()
    }
}

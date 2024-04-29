//
//  StagingView.swift
//  TaskTracker
//
//  Created by Swain Yun on 3/30/24.
//

import SwiftUI

struct CoreView<ViewModel: CoreViewModel>: View {
    @ObservedObject private var viewModel: ViewModel
    @Namespace var animation
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
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

extension CoreView {
    private var background: some View {
        Color.theme.backgroundColor
            .ignoresSafeArea()
    }
    
    private var sideMenu: some View {
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
            ProgressCircleView(progress: viewModel.tasksCompletionRate)
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
                viewModel.hideMenu()
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
            ForEach(viewModel.selectableStages) { stage in
                StageButton(selectedStage: $viewModel.selectedStage, stage: stage, animation: animation)
            }
        }
    }
    
    private var stageTabArea: some View {
        ZStack {
            Color.theme.backgroundColor
                .opacity(0.5)
                .clipShape(RoundedRectangle(cornerRadius: viewModel.isMenuPresented ? 45 : 0))
                .shadow(color: .black.opacity(0.07), radius: 5, x: -10, y: 0)
                .offset(x: viewModel.isMenuPresented ? -25 : 0)
                .padding(.vertical, 30)
            
            Color.theme.backgroundColor
                .opacity(0.4)
                .clipShape(RoundedRectangle(cornerRadius: viewModel.isMenuPresented ? 45 : 0))
                .shadow(color: .black.opacity(0.07), radius: 5, x: -10, y: 0)
                .offset(x: viewModel.isMenuPresented ? -50 : 0)
                .padding(.vertical, 60)
            
            StageTab(isMenuPresented: $viewModel.isMenuPresented, selectedStage: $viewModel.selectedStage)
                .clipShape(RoundedRectangle(cornerRadius: viewModel.isMenuPresented ? 45 : 0))
        }
        .scaleEffect(viewModel.isMenuPresented ? 0.04 : 1)
        .offset(x: viewModel.isMenuPresented ? rect.width - 120 : 0)
        .ignoresSafeArea()
    }
}

//
//  MenuButton.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/23.
//

import SwiftUI

struct StageButton: View {
    @EnvironmentObject private var stagingVM: StagingViewModel
    
    let stage: Stage
    let animation: Namespace.ID
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: stage.imageName)
                .font(.title2)
            
            Text(stage.id)
                .fontWeight(.semibold)
        }
        .foregroundColor(stagingVM.selectedStage.id == stage.id ? .theme.secondaryColor : .theme.accentColor)
        .padding()
        .onTapGesture {
            changeStage()
        }
        .frame(maxWidth: getRect().width - 170, alignment: .leading)
        .background(
            ZStack {
                if stagingVM.selectedStage.id == stage.id {
                    Color.accentColor
                        .matchedGeometryEffect(id: "stageButton", in: animation)
                        .cornerRadius(10)
                }
            }
        )
    }
    
    private func changeStage() {
        withAnimation(.spring()) {
            stagingVM.selectedStage = stage
        }
    }
}

struct StageButton_Previews: PreviewProvider {
    static var previews: some View {
        StagingView()
    }
}

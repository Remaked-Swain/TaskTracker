//
//  MenuButton.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/23.
//

import SwiftUI

struct MenuButton: View {
    @EnvironmentObject private var stagingVM: StagingViewModel
    
    let stage: Stage
    let animation: Namespace.ID
    
    var body: some View {
        Button {
            changeStage()
        } label: {
            HStack(spacing: 10) {
                Image(systemName: stage.imageName)
                    .font(.title2)
                
                Text(stage.id)
                    .fontWeight(.semibold)
            }
            .foregroundColor(stagingVM.selectedStage.id == stage.id ? .accentColor : .secondary)
            .padding(.vertical)
        }

    }
    
    private func changeStage() {
        withAnimation(.spring()) {
            stagingVM.selectedStage = stage
        }
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        StagingView()
            .environmentObject(StagingViewModel())
    }
}
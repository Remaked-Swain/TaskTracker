//
//  StageButton.swift
//  TaskTracker
//
//  Created by Swain Yun on 3/31/24.
//

import SwiftUI

struct StageButton: View {
    @Binding var selectedStage: StageType
    
    private let geometryEffectId: String = "stageButton"
    let stage: StageType
    let animation: Namespace.ID
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: stage.imageName)
                .font(.title2)
            
            Text(stage.title)
                .fontWeight(.semibold)
        }
        .foregroundStyle(selectedStage == stage ? .white : .theme.accentColor)
        .padding()
        .onTapGesture {
            withAnimation(.spring()) {
                selectedStage = stage
            }
        }
        .frame(maxWidth: self.rect.width - 170, alignment: .leading)
        .background(background)
    }
    
    private var background: some View {
        ZStack {
            if selectedStage == stage {
                Color.theme.accentColor
                    .matchedGeometryEffect(id: geometryEffectId, in: animation)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}

#Preview {
    StagingView(fetchTasksCompletionRateUseCase: DefaultFetchTasksCompletionRateUseCase(taskListRepository: DefaultTaskListRepository()))
}

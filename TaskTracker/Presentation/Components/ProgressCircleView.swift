//
//  ProgressCircle.swift
//  TaskTracker
//
//  Created by Swain Yun on 3/30/24.
//

import SwiftUI

struct ProgressCircleView: View {
    private let lineWidth: CGFloat = 10
    private let opacity: CGFloat = 0.3
    private let rotationEffectDegree: Angle = Angle(degrees: -90)
    
    let progress: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundStyle(Color.theme.secondaryColor)
                .opacity(opacity)
            
            Circle()
                .trim(from: .zero, to: progress)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .foregroundStyle(Color.theme.accentColor)
                .rotationEffect(rotationEffectDegree)
                .animation(.spring(), value: progress)
        }
    }
}

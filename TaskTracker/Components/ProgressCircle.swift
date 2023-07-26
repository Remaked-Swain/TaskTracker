//
//  ProgressCircle.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/26.
//

import SwiftUI

struct ProgressCircle: View {
    let totalTasksCount: Int
    let completedTasksCount: Int
    
    private var progress: Double {
        guard totalTasksCount > 0 else { return 0.0 }
        let ratio = Double(completedTasksCount) / Double(totalTasksCount)
        return min(max(ratio, 0.0), 1.0)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .foregroundColor(.accentColor)
                .opacity(0.3)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(progress))
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .foregroundColor(.accentColor)
                .rotationEffect(Angle(degrees: -90))
                .animation(.spring(), value: progress)
        }
    }
}

struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircle(totalTasksCount: 10, completedTasksCount: 4)
    }
}

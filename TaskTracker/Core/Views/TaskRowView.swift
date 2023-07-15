//
//  TaskRowView.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/15.
//

import SwiftUI

struct TaskRowView: View {
    let task: TaskModel
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground).ignoresSafeArea()
            
            HStack {
                
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        TaskRowView(task: dev.tasks.first!)
    }
}

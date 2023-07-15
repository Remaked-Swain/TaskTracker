//
//  DoneButton.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/15.
//

import SwiftUI

struct DoneButton: View {
    @State private var isComplete: Bool = false
    
    var body: some View {
        Circle()
            .stroke(Color.accentColor, lineWidth: 8)
    }
}

struct DoneButton_Previews: PreviewProvider {
    static var previews: some View {
        DoneButton()
            .padding()
    }
}

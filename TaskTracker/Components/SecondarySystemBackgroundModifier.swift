//
//  SecondarySystemBackgroundModifier.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/16.
//

import Foundation
import SwiftUI

struct SecondarySystemBackgroundModifier: ViewModifier {
    let backgroundColor: Color
    let foregroundColor: Color
    let font: Font
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .cornerRadius(10)
    }
}

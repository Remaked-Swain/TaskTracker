//
//  Modifier.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/16.
//

import Foundation
import SwiftUI

extension View {
    func secondarySystemBackgroundModifier(foregroundColor: Color = .black, font: Font = .headline) -> some View {
        self.modifier(
            SecondarySystemBackgroundModifier(
                backgroundColor: Color(.secondarySystemBackground),
                foregroundColor: foregroundColor,
                font: font
            )
        )
    }
    
    func autoCorrectionDisabledTextField() -> some View {
        self.modifier(TextFieldModifier())
    }
}

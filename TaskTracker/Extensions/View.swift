//
//  Modifier.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/16.
//

import Foundation
import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
}

extension View {
    func autoCorrectionDisabledTextField() -> some View {
        self.modifier(TextFieldModifier())
    }
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

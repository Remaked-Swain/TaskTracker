//
//  View.swift
//  TaskTracker
//
//  Created by Swain Yun on 3/30/24.
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
    var rect: CGRect {
        return UIScreen.main.bounds
    }
    
    func disableAutoCorrection() -> some View {
        self.modifier(TextFieldModifier())
    }
}

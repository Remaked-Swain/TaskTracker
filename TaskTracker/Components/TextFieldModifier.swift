//
//  TextFieldModifier.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/17.
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

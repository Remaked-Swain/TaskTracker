//
//  Modifier.swift
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

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
}

struct SettingButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.accentColor)
            .frame(width: 250, height: 170)
            .background(Color.white)
            .cornerRadius(25)
            .shadow(radius: 10)
    }
}

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
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

//
//  Color.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/26.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = Theme()
}

struct Theme {
    let accentColor = Color("AccentColor")
    let backgroundColor = Color("BackgroundColor")
    let secondaryColor = Color("SecondaryColor")
}

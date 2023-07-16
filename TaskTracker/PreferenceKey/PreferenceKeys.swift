//
//  PreferenceKeys.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/16.
//

import Foundation
import SwiftUI

// AddTaskButton 의 프레임 사이즈를 특정할 수 있는 Custom PreferenceKey
struct ButtonFramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

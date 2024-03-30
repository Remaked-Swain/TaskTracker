//
//  Double.swift
//  TaskTracker
//
//  Created by Swain Yun on 3/30/24.
//

import Foundation

extension Double {
    /**
     Double형 숫자를 백분율 형태의 String 값으로 출력
     
     ```swift
     1.2345 -> "1.23"
     1.2 -> "1.2"
     1.0 -> "1"
     ```
     */
    func byPercentage() -> String? {
        guard self.isNaN == false, self.isInfinite == false, self.isSignalingNaN == false else {
            return nil
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = self.truncatingRemainder(dividingBy: 1) == 0 ? 0 : 2
        return formatter.string(from: NSNumber(value: self))
    }
}


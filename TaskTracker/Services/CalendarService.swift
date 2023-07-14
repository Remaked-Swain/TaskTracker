//
//  CalendarService.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/14.
//

import Foundation

class CalendarService {
    static let shared = CalendarService()
    
    private let calendar = Calendar.current
    
    private init() {}
    
    func timeRemainingComponents(from startDate: Date, to endDate: Date) -> DateComponents {
        return calendar.dateComponents([.day, .hour, .minute, .second], from: startDate, to: endDate)
    }
}

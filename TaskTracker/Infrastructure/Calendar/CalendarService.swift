//
//  CalendarService.swift
//  TaskTracker
//
//  Created by Swain Yun on 5/2/24.
//

import Foundation

protocol CalendarService {
    func calculateRemainingTime(to deadline: Date) -> Date?
}

final class DefaultCalendarService {
    private let calendar = Calendar.current
}

// MARK: CalendarService Confirmation
extension DefaultCalendarService: CalendarService {
    func calculateRemainingTime(to deadline: Date) -> Date? {
        let remainingTime = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: .now, to: deadline)
        return calendar.date(from: remainingTime)
    }
}

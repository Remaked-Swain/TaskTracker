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
    
    func getRemainingTime(deadline: Date?) -> String {
        guard let deadline = deadline else { return "" }
        
        let now = Date()
        let remainingTime = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now, to: deadline)
        
        if let years = remainingTime.year, years > 0 {
            return "\(years)년 이상"
        } else if let months = remainingTime.month, months > 0 {
            return "\(months)월 \(remainingTime.day ?? 0)일"
        } else if let days = remainingTime.day, days > 2 {
            return "\(days)일"
        } else if let days = remainingTime.day, days == 2 {
            return "모레"
        } else if let days = remainingTime.day, days == 1 {
            return "내일"
        } else if let hours = remainingTime.hour, hours > 0 {
            return "\(hours)시간 \(remainingTime.minute ?? 0)분 \(remainingTime.second ?? 0)초"
        } else if let minutes = remainingTime.minute, minutes > 0 {
            return "\(minutes)분 \(remainingTime.second ?? 0)초"
        } else if let seconds = remainingTime.second, seconds >= 0 {
            return "\(seconds)초"
        } else {
            return "기한 초과"
        }
    }
}

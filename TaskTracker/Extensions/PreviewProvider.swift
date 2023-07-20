//
//  PreviewProvider.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/14.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

struct DeveloperPreview {
    static let instance = DeveloperPreview()
    
    private init() {}
    
    let coreDataManager = CoreDataManager.shared

    let tasks: [TaskModel] = [
        TaskModel(title: "영화 보기", taskDescription: "새로 개봉한 영화 관람하기", deadline: randomDateInOneMonth(), isCompleted: false, category: "문화/여가"),
        TaskModel(title: "스위프트 공부", taskDescription: "스위프트 프로그래밍 언어 공부하기", deadline: randomDateInOneMonth(), isCompleted: true, category: "개발"),
        TaskModel(title: "운동하기", taskDescription: "체력 단련을 위해 조깅하기", deadline: randomDateInOneMonth(), isCompleted: false, category: "건강"),
        TaskModel(title: "책 읽기", taskDescription: "잠깐 휴식을 취하며 책 읽기", deadline: nil, isCompleted: false, category: "문화/여가"),
        TaskModel(title: "앱 디자인", taskDescription: "TaskTracker 앱 디자인 개선하기", deadline: randomDateInOneMonth(), isCompleted: true, category: "디자인"),
        TaskModel(title: "과일 쇼핑", taskDescription: "과일가게에서 신선한 과일 사오기", deadline: nil, isCompleted: false, category: "일상"),
        TaskModel(title: "자료 정리", taskDescription: "노트 정리 및 파일 정돈하기", deadline: randomDateInOneMonth(), isCompleted: true, category: "일상"),
        TaskModel(title: "자전거 타기", taskDescription: "공원에서 자전거 타기", deadline: nil, isCompleted: false, category: "문화/여가"),
        TaskModel(title: "영어 회화 학습", taskDescription: "일상 영어 회화 실력 향상하기", deadline: randomDateInOneMonth(), isCompleted: false, category: "교육"),
        TaskModel(title: "요리 연습", taskDescription: "새로운 레시피로 요리 연습하기", deadline: randomDateInOneMonth(), isCompleted: true, category: "일상")
    ]
    
    static private func randomDateInOneMonth() -> Date {
        let currentDate = Date()
        let oneMonthInSeconds: TimeInterval = 30 * 24 * 60 * 60 // 1달 -> 2,592,000초
        let randomTime = TimeInterval(arc4random_uniform(UInt32(oneMonthInSeconds)))
        return currentDate.addingTimeInterval(randomTime)
    }
}

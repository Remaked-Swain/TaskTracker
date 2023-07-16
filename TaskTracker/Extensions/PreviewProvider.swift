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
    
    static let currentDate = Date()

    let tasks: [TaskModel] = [
        TaskModel(title: "식료품 구매", taskDescription: "우유, 달걀, 빵", deadline: currentDate.addingTimeInterval(3600)),
        TaskModel(title: "프로젝트 완료", taskDescription: "남은 작업 완료하기", deadline: currentDate.addingTimeInterval(86400)),
        TaskModel(title: "엄마에게 전화", taskDescription: "생일 축하 인사하기", deadline: currentDate.addingTimeInterval(172800)),
        TaskModel(title: "운동 가기", deadline: nil),
        TaskModel(title: "책 읽기", taskDescription: "도서관에서 책 선택하기", deadline: currentDate.addingTimeInterval(259200)),
        TaskModel(title: "공과금 납부", taskDescription: "전기, 수도, 인터넷", deadline: currentDate.addingTimeInterval(345600)),
        TaskModel(title: "집 청소", taskDescription: "청소기로 청소하고 먼지 털기", deadline: currentDate.addingTimeInterval(432000)),
        TaskModel(title: "휴가 계획", taskDescription: "여행지 조사하고 항공권 예매하기", deadline: currentDate.addingTimeInterval(518400)),
        TaskModel(title: "미팅 참석", taskDescription: "발표 자료 준비하기", deadline: currentDate.addingTimeInterval(604800)),
        TaskModel(title: "영화 보기", taskDescription: "영화 선택하고 친구들 초대하기", deadline: currentDate.addingTimeInterval(691200)),
    ]
}

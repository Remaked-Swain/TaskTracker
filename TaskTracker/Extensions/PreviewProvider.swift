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
        TaskModel(),
        TaskModel(
            title: "프로젝트 제안서 완료하기",
            taskDescription: "마감 기한 전에 프로젝트 제안서 작성 및 제출하기.",
            deadline: Date(timeIntervalSinceNow: 86400), // 현재로부터 1일 후
            isCompleted: false,
            category: "업무"
        ),
        TaskModel(
            title: "식료품 구매하기",
            taskDescription: "우유, 달걀, 빵 및 과일 구매하기.",
            deadline: nil,
            isCompleted: true,
            category: "개인"
        ),
        TaskModel(
            title: "'아이를 죽이는 거짓말' 읽기",
            taskDescription: "매일 적어도 세 장씩 읽기.",
            deadline: Date(timeIntervalSinceNow: 604800), // 현재로부터 1주일 후
            isCompleted: false,
            category: "독서"
        ),
        TaskModel(
            title: "존에게 전화하기",
            taskDescription: "존의 안부를 확인하고 어떻게 지내는지 확인하기.",
            deadline: nil,
            isCompleted: false,
            category: nil
        ),
        TaskModel(
            title: "발표 슬라이드 완료하기",
            taskDescription: "",
            deadline: Date(timeIntervalSinceNow: 172800), // 현재로부터 2일 후
            isCompleted: true,
            category: "업무"
        ),
        TaskModel(
            title: "기타 연습하기",
            taskDescription: "새로운 노래의 코드 배우기.",
            deadline: nil,
            isCompleted: false,
            category: "취미"
        ),
        TaskModel(
            title: "세금 서류 제출하기",
            taskDescription: "필요한 모든 서류 모으고 제출하기.",
            deadline: Date(timeIntervalSinceNow: 2592000), // 현재로부터 1달 후
            isCompleted: false,
            category: "재무"
        ),
        TaskModel(
            title: "취업 면접 준비하기",
            taskDescription: "회사 조사하기, 일반적인 면접 질문 연습하고 전문적으로 차려 입기.",
            deadline: Date(timeIntervalSinceNow: 1728000), // 현재로부터 3주일 후
            isCompleted: true,
            category: "경력"
        ),
        TaskModel(
            title: "여름 휴가 계획하기",
            taskDescription: "여행지 결정하기, 항공편 예약하기, 숙박 시설 예약하고 일일 활동 계획하기.",
            deadline: Date(timeIntervalSinceNow: 6048000), // 현재로부터 2달 후
            isCompleted: false,
            category: "여행"
        )
    ]
    
    let categories = ["분류 없음", "업무", "개인", "독서", "취미", "재무", "경력", "여행"]
}

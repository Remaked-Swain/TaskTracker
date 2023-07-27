//
//  StageModel.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/23.
//

import Foundation

// 앱의 모든 스테이지들을 정의
// 계정, 할 일 목록, 카테고리 관리, 설정
@frozen enum Stage: String, Identifiable, CaseIterable {
    case account, core, categories, setting
    
    var id: String {
        switch self {
        case .account: return "계정"
        case .core: return "할 일 목록"
        case .categories: return "카테고리 관리"
        case .setting: return "설정"
        }
    }
    
    var imageName: String {
        switch self {
        case .account: return "person.circle"
        case .core: return "doc.text.fill"
        case .categories: return "bookmark.circle"
        case .setting: return "gear.circle"
        }
    }
}

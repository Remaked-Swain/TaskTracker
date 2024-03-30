//
//  StageType.swift
//  TaskTracker
//
//  Created by Swain Yun on 3/30/24.
//

import Foundation

enum StageType: Identifiable, CaseIterable {
    case account, core, categories, setting
    
    var id: String {
        self.title
    }
    
    var title: String {
        switch self {
        case .account: "계정"
        case .core: "할 일 목록"
        case .categories: "카테고리 관리"
        case .setting: "설정"
        }
    }
    
    var imageName: String {
        switch self {
        case .account: "person.circle"
        case .core: "doc.text.fill"
        case .categories: "bookmark.circle"
        case .setting: "gear.circle"
        }
    }
}

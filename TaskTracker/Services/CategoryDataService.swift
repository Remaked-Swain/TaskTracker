//
//  CategoryDataService.swift
//  TaskTracker
//
//  Created by Swain Yun on 2023/07/18.
//

import Foundation
import Combine

class CategoryDataService: ObservableObject {
    @Published var allCategories: [String] = ["없음"]
    
    private let coreDataManager = CoreDataManager.shared
    
    init() {
        setupObserver()
    }
    
    private func setupObserver() {
        coreDataManager.fetchCategories { [weak self] categoryEntities in
            let categories = categoryEntities.map {$0.name}
            
            DispatchQueue.main.async {
                // 카테고리가 모두 삭제되어도 "없음" 카테고리는 남아있어야 함.
                self?.allCategories = ["없음"] + categories.compactMap {$0}
            }
        }
    }
    
    func addCategory(_ category: String) {
        // "없음" 카테고리의 무한생성 방지
        guard category != "없음" else { return }
        
        coreDataManager.saveCategory(category)
    }
    
    func deleteCategory(_ category: String) {
        // "없음" 카테고리 삭제 방지
        guard category != "없음" else { return }
        
        coreDataManager.deleteCategory(category)
    }
}

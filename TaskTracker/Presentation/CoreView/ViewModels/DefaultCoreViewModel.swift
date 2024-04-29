//
//  CoreViewModel.swift
//  TaskTracker
//
//  Created by Swain Yun on 3/31/24.
//

import Foundation

protocol CoreViewModel: ObservableObject {
    
}

final class DefaultCoreViewModel: ObservableObject {
    // MARK: Dependencies
    private let fetchTasksCompletionRateUseCase: FetchTasksCompletionRateUseCase
    
    // MARK: Properties
    @Published var tasksCompletionRate: CGFloat = 0
    let selectableStages = StageType.allCases
    
    init(fetchTasksCompletionRateUseCase: FetchTasksCompletionRateUseCase) {
        self.fetchTasksCompletionRateUseCase = fetchTasksCompletionRateUseCase
    }
    
    // MARK: Public Methods
    func calculateTasksCompletionRate()  {
        Task {
            tasksCompletionRate = await fetchTasksCompletionRateUseCase.fetchTasksComletionRate()
        }
    }
}

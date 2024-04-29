//
//  CoreViewModel.swift
//  TaskTracker
//
//  Created by Swain Yun on 3/31/24.
//

import Foundation
import Combine

protocol CoreViewModel: ObservableObject {
    func calculateTasksCompletionRate()
}

final class DefaultCoreViewModel: ObservableObject {
    // MARK: Dependencies
    private let fetchTasksCompletionRateUseCase: FetchTasksCompletionRateUseCase
    
    // MARK: Properties
    @Published var tasksCompletionRate: CGFloat = 0
    let selectableStages = StageType.allCases
    private var cancellables: Set<AnyCancellable> = []
    
    init(fetchTasksCompletionRateUseCase: FetchTasksCompletionRateUseCase) {
        self.fetchTasksCompletionRateUseCase = fetchTasksCompletionRateUseCase
    }
}

// MARK: CoreViewModel Confirmation
extension DefaultCoreViewModel: CoreViewModel {
    func calculateTasksCompletionRate()  {
        Task {
            tasksCompletionRate = await fetchTasksCompletionRateUseCase.fetchTasksComletionRate()
        }
    }
}

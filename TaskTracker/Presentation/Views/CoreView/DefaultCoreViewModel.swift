//
//  CoreViewModel.swift
//  TaskTracker
//
//  Created by Swain Yun on 3/31/24.
//

import Foundation
import Combine

protocol CoreViewModel: ObservableObject {
    var selectedStage: StageType { get set }
    var isMenuPresented: Bool { get set }
    var tasksCompletionRate: CGFloat { get }
    var selectableStages: [StageType] { get }
    
    func calculateTasksCompletionRate()
    func hideMenu()
}

final class DefaultCoreViewModel: ObservableObject {
    // MARK: Dependencies
    private let fetchTasksCompletionRateUseCase: FetchTasksCompletionRateUseCase
    
    // MARK: Properties
    @Published var tasksCompletionRate: CGFloat = 0
    @Published var selectedStage: StageType = .core
    @Published var isMenuPresented: Bool = false
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
    
    func hideMenu() {
        isMenuPresented = false
    }
}

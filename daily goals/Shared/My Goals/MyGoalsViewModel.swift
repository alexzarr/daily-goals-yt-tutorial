//
//  MyGoalsViewModel.swift
//  daily goals
//
//  Created by alex.zarr on 4/13/21.
//

import Foundation

final class MyGoalsViewModel: ObservableObject {
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
    
    func markAsDone(_ goal: TLGoal) {
        guard !goal.isCompletedToday else { return }
        dataManager.createGoalRecord(for: goal.id, date: Date())
    }
    
    func unmarkAsDone(_ goal: TLGoal) {
        dataManager.deleteGoalRecord(for: goal.id, date: Date())
    }
}

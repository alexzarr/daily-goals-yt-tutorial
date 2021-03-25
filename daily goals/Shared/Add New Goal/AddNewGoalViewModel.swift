//
//  AddNewGoalViewModel.swift
//  daily goals
//
//  Created by alex.zarr on 3/25/21.
//

import Foundation

final class AddNewGoalViewModel: ObservableObject {
    @Published var title = ""
    @Published var icon = GoalIcon.all[0]
    
    let icons = GoalIcon.all
    
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
    
    func save(completion: (_ success: Bool) -> Void) {
        var success = false
        defer { completion(success) }
        guard !title.isEmpty else { return }
        dataManager.createGoal(title: title, icon: icon)
        success = true
    }
}

//
//  DataManager.swift
//  daily goals
//
//  Created by alex.zarr on 3/25/21.
//

import Foundation
import CoreData

protocol GoalDataManagerProtocol {
    func createGoal(title: String, icon: String)
}

typealias DataManagerProtocol = GoalDataManagerProtocol

final class DataManager {
    static let shared = DataManager()
    
    private let persistenceController: PersistenceController
    private var context: NSManagedObjectContext { persistenceController.container.viewContext }
    
    init(persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController
    }
}

// MARK: - GoalDataManagerProtocol
extension DataManager: GoalDataManagerProtocol {
    func createGoal(title: String, icon: String) {
        context.performAndWait {
            let request: NSFetchRequest<TLGoal> = TLGoal.fetchRequest()
            do {
                let goals = try context.fetch(request)
                for (index, goal) in goals.enumerated() {
                    goal.position = Int16(index + 1)
                }
                
                let goal = TLGoal(context: context)
                goal.id = UUID()
                goal.title = title
                goal.icon = icon
                goal.position = 0
                goal.addedOn = Date()
                goal.modifiedOn = Date()
                
                try context.save()
            } catch {
                fatalError("error: \(error)")
            }
        }
    }
}

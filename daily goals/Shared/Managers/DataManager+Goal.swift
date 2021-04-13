//
//  DataManager+Goal.swift
//  daily goals
//
//  Created by alex.zarr on 4/13/21.
//

import Foundation
import CoreData

protocol GoalDataManagerProtocol {
    func createGoal(title: String, icon: String)
    func readGoal(id: UUID) -> TLGoal?
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
    
    func readGoal(id: UUID) -> TLGoal? {
        var goal: TLGoal?
        context.performAndWait {
            let request: NSFetchRequest<TLGoal> = TLGoal.fetchRequest()
            var predicates: [NSPredicate] = []
            if let predicate = request.predicate {
                predicates.append(predicate)
            }
            predicates.append(NSPredicate(format: "id = %@", argumentArray: [id]))
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            request.fetchLimit = 1
            do {
                goal = try context.fetch(request).first
            } catch {
                fatalError("error: \(error)")
            }
        }
        return goal
    }
}

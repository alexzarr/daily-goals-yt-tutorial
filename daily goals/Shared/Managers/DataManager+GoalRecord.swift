//
//  GoalRecordDataManagerProtocol.swift
//  daily goals
//
//  Created by alex.zarr on 4/13/21.
//

import Foundation
import CoreData

protocol GoalRecordDataManagerProtocol {
    func createGoalRecord(for goalID: UUID, date: Date)
    func readGoalRecord(for goalID: UUID, date: Date) -> TLGoalRecord?
    func deleteGoalRecord(for goalID: UUID, date: Date)
}

extension GoalRecordDataManagerProtocol {
    func createGoalRecord(for goalID: UUID, date: Date = Date()) { createGoalRecord(for: goalID, date: date) }
    func readGoalRecord(for goalID: UUID, date: Date = Date()) -> TLGoalRecord? { readGoalRecord(for: goalID, date: date) }
    func deleteGoalRecord(for goalID: UUID, date: Date = Date()) { deleteGoalRecord(for: goalID, date: date) }
}

// MARK: - GoalRecordDataManagerProtocol
extension DataManager: GoalRecordDataManagerProtocol {
    func createGoalRecord(for goalID: UUID, date: Date) {
        context.performAndWait {
            guard let goal = readGoal(id: goalID) else { return }
            let goalRecord = TLGoalRecord(context: context)
            goalRecord.goal = goal
            goalRecord.date = date
            do {
                try context.save()
            } catch {
                fatalError("error: \(error)")
            }
        }
    }
    
    func readGoalRecord(for goalID: UUID, date: Date) -> TLGoalRecord? {
        var goalRecord: TLGoalRecord?
        context.performAndWait {
            let request: NSFetchRequest<TLGoalRecord> = TLGoalRecord.fetchRequest()
            var predicates: [NSPredicate] = []
            if let predicate = request.predicate {
                predicates.append(predicate)
            }
            let calendar = Calendar.current
            let startDate = calendar.startOfDay(for: date)
            let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
            predicates.append(NSPredicate(format: "goal.id = %@ AND date >= %@ AND date < %@", argumentArray: [goalID, startDate, endDate]))
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            request.fetchLimit = 1
            do {
                goalRecord = try context.fetch(request).first
            } catch {
                fatalError("error: \(error)")
            }
        }
        return goalRecord
    }
    
    func deleteGoalRecord(for goalID: UUID, date: Date) {
        context.performAndWait {
            while let goalRecord = readGoalRecord(for: goalID, date: date) {
                context.delete(goalRecord)
            }
            guard context.hasChanges else { return }
            do {
                try context.save()
            } catch {
                fatalError("error: \(error)")
            }
        }
    }
}

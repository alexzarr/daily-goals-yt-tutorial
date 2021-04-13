//
//  TLGoal.swift
//  daily goals
//
//  Created by alex.zarr on 3/16/21.
//

import Foundation
import CoreData

@objc(TLGoal)
final class TLGoal: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var icon: String
    @NSManaged public var title: String
    @NSManaged public var position: Int16
    @NSManaged public var addedOn: Date
    @NSManaged public var modifiedOn: Date
    @NSManaged public var isRemoved: Bool
    @NSManaged public var records: Set<TLGoalRecord>?
}

extension TLGoal {
    class func fetchRequest() -> NSFetchRequest<TLGoal> {
        let request = NSFetchRequest<TLGoal>(entityName: "TLGoal")
        request.predicate = NSPredicate(format: "isRemoved = false")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \TLGoal.position, ascending: true)]
        return request
    }
}

// MARK: - Identifiable
extension TLGoal: Identifiable { }

extension TLGoal {
    var lastRecord: TLGoalRecord? {
        records?.sorted { $0.date > $1.date }.first
    }
    
    var isCompletedToday: Bool {
        guard let lastRecord = lastRecord else { return false }
        return Calendar.current.isDateInToday(lastRecord.date)
    }
}

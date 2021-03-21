//
//  TLGoalRecord.swift
//  daily goals
//
//  Created by alex.zarr on 3/18/21.
//

import Foundation
import CoreData

@objc(TLGoalRecord)
final class TLGoalRecord: NSManagedObject {
    @NSManaged public var date: Date
    @NSManaged public var goal: TLGoal?
}

extension TLGoalRecord {
    class func fetchRequest() -> NSFetchRequest<TLGoalRecord> {
        let request = NSFetchRequest<TLGoalRecord>(entityName: "TLGoal")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \TLGoalRecord.date, ascending: false)]
        return request
    }
}

// MARK: - Identifiable
extension TLGoalRecord: Identifiable { }

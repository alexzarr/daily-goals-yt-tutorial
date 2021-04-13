//
//  DataManager.swift
//  daily goals
//
//  Created by alex.zarr on 3/25/21.
//

import Foundation
import CoreData

typealias DataManagerProtocol = GoalDataManagerProtocol & GoalRecordDataManagerProtocol

final class DataManager {
    static let shared = DataManager()
    
    let persistenceController: PersistenceController
    var context: NSManagedObjectContext { persistenceController.container.viewContext }
    
    init(persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController
    }
}



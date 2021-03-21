//
//  ContentView.swift
//  Shared
//
//  Created by alex.zarr on 3/16/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: TLGoal.fetchRequest())
    private var goals: FetchedResults<TLGoal>

    var body: some View {
        List {
            ForEach(goals) { goal in
                HStack {
                    Text(goal.icon)
                    Text(goal.title)
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

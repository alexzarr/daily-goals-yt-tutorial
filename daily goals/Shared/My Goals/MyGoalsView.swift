//
//  MyGoalsView.swift
//  Shared
//
//  Created by alex.zarr on 3/16/21.
//

import SwiftUI
import CoreData

struct MyGoalsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: TLGoal.fetchRequest())
    private var goals: FetchedResults<TLGoal>
    
    @State private var showingAddNew = false
    
    private var columns: [GridItem] { [GridItem(.adaptive(minimum: 100, maximum: 160), spacing: 10.0)] }

    var body: some View {
        NavigationView {
            Group {
                if goals.isEmpty {
                    Text("No goals yet!")
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10.0) {
                            ForEach(goals) { goal in
                                MyGoalsItemView(goal: goal)
                            }
                        }
                        .padding(10)
                    }
                }
            }
            .navigationTitle(Text("Goals"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    addNewButton
                }
            }
        }
        .sheet(isPresented: $showingAddNew) {
            AddNewGoalView()
        }
        
    }
    
    private var addNewButton: some View {
        Button {
            showingAddNew = true
        } label: {
            Text("New")
        }
    }
}

struct MyGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        MyGoalsView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

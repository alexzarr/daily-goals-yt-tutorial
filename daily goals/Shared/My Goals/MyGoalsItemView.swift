//
//  MyGoalsItemView.swift
//  daily goals
//
//  Created by alex.zarr on 3/25/21.
//

import SwiftUI

struct MyGoalsItemView: View {
    @ObservedObject var goal: TLGoal
    
    var body: some View {
        VStack {
            Text(goal.icon)
                .font(.system(size: 60))
            Text(goal.title)
                .font(.footnote)
                .foregroundColor(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1.0, contentMode: .fill)
        .padding(4)
        .background(Color.tlBackground)
        .cornerRadius(8.0)
        .shadow(color: .gray, radius: 3.0, x: 0.0, y: 0.0)
    }
}

struct MyGoalsItemView_Previews: PreviewProvider {
    static var goal: TLGoal {
        let goal = TLGoal(context: PersistenceController.preview.container.viewContext)
        goal.id = UUID()
        goal.icon = "🍩"
        goal.title = "Avoid Sugar"
        goal.position = 0
        goal.addedOn = Date()
        goal.modifiedOn = Date()
        goal.isRemoved = false
        return goal
    }
    static var previews: some View {
        MyGoalsItemView(goal: goal)
            .previewLayout(.fixed(width: 160, height: 160))
    }
}

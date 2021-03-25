//
//  AddNewGoalView.swift
//  daily goals
//
//  Created by alex.zarr on 3/25/21.
//

import SwiftUI

struct AddNewGoalView: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var viewModel = AddNewGoalViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .padding()
                }
                Spacer()
                Button {
                    viewModel.save { result in
                        if result {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                } label: {
                    Text("Create")
                        .bold()
                        .padding()
                }
            }
            Divider()
            Form {
                Section {
                    TextField("Title", text: $viewModel.title)
                }
                Section(header: Text("Icon")) {
                    Picker("Icon", selection: $viewModel.icon) {
                        ForEach(viewModel.icons, id: \.self) { icon in
                            Text(icon)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
            }
        }
    }
}

struct AddNewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewGoalView()
    }
}

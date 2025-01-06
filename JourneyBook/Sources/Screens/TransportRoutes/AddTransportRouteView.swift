//
//  AddTransportRouteView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import SwiftUI

struct AddTransportRouteView: SheetView {
    @State var model = AddTransportRouteViewModel()

    var content: some View {
        Form {
            Section("Route Name") {
                TextField("Route Name", text: model.routeNameBinding)
            }
            Section("Route") {
                if let url = model.url {
                    Text("\(url)")
                } else {
                    Button("Select Transport Route Online") {}
                }
            }
        }
    }

    var confirmButton: some View {
        Button("Save") {
            model.saveItem()
        }
        .disabled(!model.saveable)
    }

    var sheetTitle: String {
        "Add New Route"
    }
}

extension AddTransportRouteViewModel {
    var routeNameBinding: Binding<String> {
        Binding(
            get: { self.routeName ?? "" },
            set: {
                if $0 == "" {
                    self.routeName = nil
                } else {
                    self.routeName = $0
                }
            }
        )
    }
}

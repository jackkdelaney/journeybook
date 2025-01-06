//
//  AddTransportRouteView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import SwiftUI

struct AddTransportRouteView: SheetView {
    @Environment(\.dismiss) var dismiss

    @State var model = AddTransportRouteViewModel()

    @State private var sheet: TransportRouteSheet? = nil

    @ViewBuilder var routeContent: some View {
        if let url = model.url {
            Text("\(url)")
        } else {
            Button("Select Transport Route Online") {
                let route = TransportRouteSheetURL(binding: model.urlOptionalBinding)
                sheet = .getRouteUrl(route)
            }
        }
    }

    var content: some View {
        Form {
            Section("Route Name") {
                TextField("Route Name", text: model.routeNameBinding)
            }
            Section("Route") {
                routeContent
            }
        }
        .sheet(item: $sheet) { item in
            item.buildView()
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.automatic)
        }
    }

    var confirmButton: some View {
        Button("Save") {
            model.saveItem()
            dismiss()
        }
        .disabled(!model.saveable)
    }

    var sheetTitle: String {
        "Add New Route"
    }
}

extension AddTransportRouteViewModel {
    var urlOptionalBinding: Binding<URL?> {
        .init(get: { self.url }, set: { self.url = $0 })
    }

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

//
//  TransportRouteSelectorView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 06/01/2025.
//

import SharedPersistenceKit
import SwiftData
import SwiftUI

struct TransportRouteSelectorView: SheetView {
    @Query var routes: [TransportRoute]

    @Binding var selectedRoute: TransportRoute?

    @State private var sheet: TransportRouteSheet? = nil

    var content: some View {
        List {
            ForEach(routes) { route in
                HStack {
                    Button {
                        selectedRoute = route
                    } label: {
                        HStack {
                            Text(route.routeName)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            if selectedRoute == route {
                                Label("Item Selected", systemImage: "checkmark")
                                    .labelStyle(.iconOnly)
                            }
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .sheet(item: $sheet) { item in
            item.buildView()
        }
        .overlay {
            if routes.isEmpty {
                ContentUnavailableView(
                    "No Routes",
                    systemImage: "engine.combustion.badge.exclamationmark"
                )
            }
        }
    }

    var confirmButton: some View {
        Button {
            sheet = .addRoute
        } label: {
            Label("Add New Route", systemImage: "plus")
        }
    }

    var sheetTitle: String {
        "Select Transport Route"
    }
}

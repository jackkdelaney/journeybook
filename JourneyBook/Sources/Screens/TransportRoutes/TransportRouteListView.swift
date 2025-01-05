//
//  TransportRouteListView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import SwiftUI
import SwiftData

struct TransportRouteListView: View {
    @EnvironmentObject private var coordinator: Coordinator

    @State private var sheet: TransportRouteSheet? = nil

    @Query var routes: [TransportRoute]
    @Environment(\.modelContext) var modelContext

    @ViewBuilder
    func contents(for resource: VisualResource) -> some View {
        if let description = resource.aidDescription {
            Text(description)
        }
    }

    func delete(at offsets: IndexSet) {
        for offset in offsets {
            let resource = routes[offset]
            modelContext.delete(resource)
        }
        do {
            try modelContext.save()
        } catch {}
    }

    var body: some View {
        List {
            ForEach(routes) { route in
                HStack {
                    Button {
                        
                    } label: {
                        Text(route.routeName)
                    }
                    .chevronButtonStyle()
                }
            }
            .onDelete(perform: delete)
        }

        .navigationTitle("Transport Routes")
        .navigationBarTitleDisplayMode(.inline)
        .overlay {
            if routes.isEmpty {
                ContentUnavailableView {
                    Label("No Routes", systemImage: "archivebox.fill")
                } description: {
                    Text("Routes that you add will appear here.")
                }
            }
        }
        .sheet(item: $sheet) { item in
            item.buildView()
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    sheet = .addRoute
                } label: {
                    Label("Add Route", systemImage: "plus")
                }
            }
        }
    }
}

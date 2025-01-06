//
//  ResourcesManager.swift
//  JourneyBook
//
//

import AVKit
import SwiftData
import SwiftUI

struct ResourcesManager: View {
    @EnvironmentObject private var coordinator: Coordinator

    @State private var sheet: ResourcesManagerSheet? = nil

    @Query var resources: [VisualResource]
    @Environment(\.modelContext) var modelContext

    @ViewBuilder
    func contents(for resource: VisualResource) -> some View {
        if let description = resource.aidDescription {
            Text(description)
        }
    }

    func delete(at offsets: IndexSet) {
        for offset in offsets {
            let resource = resources[offset]
            modelContext.delete(resource)
        }
        do {
            try modelContext.save()
        } catch {}
    }

    var body: some View {
        List {
            ForEach(resources) { resource in
                HStack {
                    Button {
                        coordinator.push(page: .resourceDetails(resource))
                    } label: {
                        contents(for: resource)
                    }
                    .chevronButtonStyle()
                }
            }
            .onDelete(perform: delete)
        }

        .navigationTitle("Resources")
        .navigationBarTitleDisplayMode(.inline)
        .overlay {
            if resources.isEmpty {
                ContentUnavailableView {
                    Label("No Resources", systemImage: "archivebox.fill")
                } description: {
                    Text("Resources that you add will appear here.")
                }
            }
        }
        .sheet(item: $sheet) { item in
            item.buildView()
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Button {
                        sheet = .addPhoto
                    } label: {
                        Label("Add Photo", systemImage: "photo.artframe")
                    }
                    Button {
                        sheet = .addVideo

                    } label: {
                        Label("Add Video", systemImage: "film")
                    }
                } label: {
                    Label("Add", systemImage: "plus")
                }
            }
        }
    }
}

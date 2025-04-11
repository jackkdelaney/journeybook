//
//  ResourceSelectionView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 03/01/2025.
//

import SwiftData
import SwiftUI
import SharedPersistenceKit

struct ResourceSelectionView: SheetView {
    @Environment(\.dismiss) var dismiss

    @Binding var selectedResources: [VisualResource]

    @Query var resources: [VisualResource]

    var content: some View {
        List {
            ForEach(resources) { resource in
                Button {
                    addOrRemove(for: resource)
                } label: {
                    HStack {
                        Text(resource.aidDescription ?? "Unamed Item")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()

                        Image(systemName: selectedResources.contains(resource) ? "checkmark.circle" : "circle")
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .accessibilityLabel("\(selectedResources.contains(resource) ? "Add" : "Remove"))  \(resource.aidDescription ?? "Aid without description")")
                    .accessibilityHint("\(selectedResources.contains(resource) ? "Add" : "Remove") to the selected Visual Resources")
                    .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }

    private func addOrRemove(for resource: VisualResource) {
        if selectedResources.contains(resource) {
            selectedResources.removeAll(where: {
                $0.id == resource.id
            })
        } else {
            selectedResources.append(resource)
        }
    }

    var confirmButton: some View {
        Button("Save") {
            dismiss()
        }
        .disabled(selectedResources.isEmpty)
    }

    var sheetTitle: String {
        "Select a Resource"
    }
}

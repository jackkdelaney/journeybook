//
//  PhotosPickerViewModel.swift
//  JourneyBook
//
//  Created by Jack Delaney on 19/12/2024.
//

import Observation
import PhotosUI
import SwiftData
import SwiftUI

@Observable
class PhotosPickerViewModel: PickerItem {
    func saveItem() {
        if let imageData = selectedItem?.pngData() {
            let resource = VisualResource(resourceData: imageData, resourceType: .image, aidDescription: selectedItemText ?? "Unnamed Photo")
            add(resource)
        }
    }

    let modelContainer: ModelContainer
    let modelContext: ModelContext

    var pickerText = "Photo"

    var selectedItem: UIImage?
    var selectedItemText: String?

    var selectedPickerItem: PhotosPickerItem? {
        didSet {
            loadImage()
        }
    }

    let filter: PHPickerFilter = .images

    @MainActor
    init(selectedItem: UIImage? = nil, selectedPickerItem: PhotosPickerItem? = nil) {
        self.selectedItem = selectedItem
        self.selectedPickerItem = selectedPickerItem

        modelContainer = try! ModelContainer(for: VisualResource.self, Phrase.self, Journey.self,LiveJourney.self, JourneyStep.self, TransportRoute.self,Communication.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        modelContext = modelContainer.mainContext
    }

    private func loadImage() {
        Task {
            if let loaded = try? await selectedPickerItem?.loadTransferable(type: Data.self) {
                selectedItem = UIImage(data: loaded)
            }
        }
    }

    func clearItem() {
        selectedPickerItem = nil
        selectedItem = nil
    }

    // CODE TO MEET Observable reuse https://forums.swift.org/t/enforce-observable-through-a-protocol/72984/5

    nonisolated func access<Member>(
        keyPath: KeyPath<PhotosPickerViewModel, Member>
    ) {
        _$observationRegistrar.access(self, keyPath: keyPath)
    }

    nonisolated func withMutation<Member, MutationResult>(
        keyPath: KeyPath<PhotosPickerViewModel, Member>,
        _ mutation: () throws -> MutationResult
    ) rethrows -> MutationResult {
        try _$observationRegistrar.withMutation(of: self, keyPath: keyPath, mutation)
    }

    @ObservationIgnored let _$observationRegistrar = Observation.ObservationRegistrar()
}

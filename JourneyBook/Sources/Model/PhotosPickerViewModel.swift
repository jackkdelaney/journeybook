//
//  PhotosPickerViewModel.swift
//  JourneyBook
//
//  Created by Jack Delaney on 19/12/2024.
//

import SwiftUI
import Observation
import PhotosUI
import SwiftData

@Observable
class PhotosPickerViewModel : PickerItem {
    
    func saveItem() {
        if let imageData = selectedItem?.pngData() {
            let resource = VisualResource(resourceData: imageData, resourceType: .image, aidDescription: selectedItemText ?? "Unnamed Photo")
            add(resource)
        } else {
            print("ISSUE!!")
        }
        
    }
    
    let modelContainer: ModelContainer
    let modelContext: ModelContext
    
    
    var pickerText = "Photo"
    
    var selectedItem: UIImage?
    var selectedItemText: String?

    var selectedPickerItem : PhotosPickerItem? {
        didSet {
            loadImage()
        }
    }
    
    let filter :PHPickerFilter = PHPickerFilter.images
    
    @MainActor
    init(selectedItem: UIImage? = nil, selectedPickerItem: PhotosPickerItem? = nil) {
        self.selectedItem = selectedItem
        self.selectedPickerItem = selectedPickerItem
        
        self.modelContainer = try! ModelContainer(for: VisualResource.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }
    
    
    private func loadImage() {
        Task {
            if let loaded = try? await selectedPickerItem?.loadTransferable(type: Data.self) {
                selectedItem = UIImage(data: loaded)
            }
        }
    }
    
    func clearItem() {
        selectedPickerItem = nil;
        selectedItem = nil;
    }
    
    //CODE TO MEET Observable reuse https://forums.swift.org/t/enforce-observable-through-a-protocol/72984/5
    
    internal nonisolated func access<Member>(
        keyPath: KeyPath<PhotosPickerViewModel, Member>
    ) {
        _$observationRegistrar.access(self,keyPath: keyPath)
    }
    
    internal nonisolated func withMutation<Member,MutationResult>(
        keyPath: KeyPath<PhotosPickerViewModel, Member>,
        _ mutation: () throws -> MutationResult
    ) rethrows -> MutationResult {
        try _$observationRegistrar.withMutation(of: self, keyPath: keyPath, mutation)
    }
    @ObservationIgnored internal let _$observationRegistrar = Observation.ObservationRegistrar()
    
    
}

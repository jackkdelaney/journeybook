//
//  VideosPickerViewModel.swift
//  JourneyBook
//
//  Created by Jack Delaney on 20/12/2024.
//


import SwiftUI
import Observation
import PhotosUI
import SwiftData

struct Movie : Transferable {
    let url: URL
    
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { movie in
            SentTransferredFile(movie.url)
        } importing: { received in
            let copy = URL.documentsDirectory.appending(path: "movie.mp4")
            
            if FileManager.default.fileExists(atPath: copy.path()) {
                try FileManager.default.removeItem(at: copy)
            }
            
            try FileManager.default.copyItem(at: received.file, to: copy)
            return Self.init(url: copy)
        }
    }
    
}

enum LoadState {
    case unknown, loading, loaded(Movie), failed
}

extension LoadState {
    func getLoadedMovie() -> Movie? {
        if case .loaded(let movie) = self {
            return movie
        }
        return nil
    }
}

@Observable
class VideosPickerViewModel : PickerItem {
    
    func saveItem() {
        if let item = selectedItem {
            if let movie = item.getLoadedMovie() {
                let videoData = try? Data(contentsOf: movie.url )
                if let videoData {
                    let resource = VisualResource(resourceData: videoData, resourceType: .video, aidDescription: selectedItemText ?? "Unnamed Video")
                    add(resource)
                }
               

            }

        }

    }
    
    let modelContainer: ModelContainer
    let modelContext: ModelContext
    
    
    let pickerText: String = "Video"

    var selectedItem: LoadState?
    var selectedItemText: String?

    var selectedPickerItem : PhotosPickerItem? {
        didSet {
            loadImage()
        }
    }
    
    let filter = PHPickerFilter.videos
    
    @MainActor
    init(selectedItem: LoadState? = nil, selectedPickerItem: PhotosPickerItem? = nil) {
        self.selectedItem = selectedItem
        self.selectedPickerItem = selectedPickerItem
        
        self.modelContainer = try! ModelContainer(for: VisualResource.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
             self.modelContext = modelContainer.mainContext
    }
    
    
    private func loadImage() {
        Task {
            do {
                selectedItem = .loading
                
                if let movie = try await selectedPickerItem?.loadTransferable(type: Movie.self) {
                    selectedItem = .loaded(movie)
                } else {
                    selectedItem = .failed
                }
            } catch {
                selectedItem = .failed
            }
        }
    }
    
    func clearItem() {
        selectedPickerItem = nil;
        selectedItem = nil;
    }
    
    //CODE TO MEET Observable reuse https://forums.swift.org/t/enforce-observable-through-a-protocol/72984/5
    
    internal nonisolated func access<Member>(
        keyPath: KeyPath<VideosPickerViewModel, Member>
    ) {
        _$observationRegistrar.access(self,keyPath: keyPath)
    }
    
    internal nonisolated func withMutation<Member,MutationResult>(
        keyPath: KeyPath<VideosPickerViewModel, Member>,
        _ mutation: () throws -> MutationResult
    ) rethrows -> MutationResult {
        try _$observationRegistrar.withMutation(of: self, keyPath: keyPath, mutation)
    }
    @ObservationIgnored internal let _$observationRegistrar = Observation.ObservationRegistrar()
    
    
}




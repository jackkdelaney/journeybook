//
//  VideosPickerViewModel.swift
//  JourneyBook
//
//  Created by Jack Delaney on 20/12/2024.
//

import Observation
import PhotosUI
import SharedPersistenceKit
import SwiftData
import SwiftUI

struct Movie: Transferable {
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
            return Self(url: copy)
        }
    }
}

extension Movie : Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.url == rhs.url
    }
}

enum LoadState: Equatable {
    case unknown, loading
    case loaded(Movie)
    case failed

}

extension LoadState {
    func getLoadedMovie() -> Movie? {
        if case let .loaded(movie) = self {
            return movie
        }
        return nil
    }

    private func value() -> String {
        switch self {
        case .failed:
            "0"
        case .loading:
            "1"
        case .unknown:
            "2"
        case let .loaded(item):
            "3\(item.url)"
        }
    }
    static func == (lhs: LoadState, rhs: LoadState) -> Bool {
        lhs.value() == rhs.value()
    }

}

@Observable
class VideosPickerViewModel: PickerItem {
    func saveItem() {
        if let item = selectedItem {
            if let movie = item.getLoadedMovie() {
                let videoData = try? Data(contentsOf: movie.url)
                if let videoData {
                    let resource = VisualResource(
                        resourceData: videoData,
                        resourceType: .video,
                        aidDescription: selectedItemText ?? "Unnamed Video"
                    )
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

    var selectedPickerItem: PhotosPickerItem? {
        didSet {
            loadImage()
        }
    }

    let filter = PHPickerFilter.videos

    @MainActor
    init(
        selectedItem: LoadState? = nil,
        selectedPickerItem: PhotosPickerItem? = nil
    ) {
        self.selectedItem = selectedItem
        self.selectedPickerItem = selectedPickerItem

        modelContainer = try! ModelContainer(
            for: VisualResource.self,
            Phrase.self,
            Journey.self,
            LiveJourney.self,
            JourneyStep.self,
            TransportRoute.self,
            Communication.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: false)
        )
        modelContext = modelContainer.mainContext
    }

    private func loadImage() {
        Task {
            do {
                selectedItem = .loading

                if let movie = try await selectedPickerItem?.loadTransferable(
                    type: Movie.self
                ) {
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
        selectedPickerItem = nil
        selectedItemText = nil
        selectedItem = nil
    }

    // CODE TO MEET Observable reuse https://forums.swift.org/t/enforce-observable-through-a-protocol/72984/5

    nonisolated func access<Member>(
        keyPath: KeyPath<VideosPickerViewModel, Member>
    ) {
        _$observationRegistrar.access(self, keyPath: keyPath)
    }

    nonisolated func withMutation<Member, MutationResult>(
        keyPath: KeyPath<VideosPickerViewModel, Member>,
        _ mutation: () throws -> MutationResult
    ) rethrows -> MutationResult {
        try _$observationRegistrar.withMutation(
            of: self,
            keyPath: keyPath,
            mutation
        )
    }

    @ObservationIgnored let _$observationRegistrar =
        Observation.ObservationRegistrar()
}

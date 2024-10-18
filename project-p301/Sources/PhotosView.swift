//
//  PhotosView.swift
//  Project301
//
//  Created by Jack Delaney on 16/10/2024.
//

import PhotosUI
import SwiftUI

struct PhotosView: View {
    @State private var processedImage: Image?
    @State private var selectedItem: PhotosPickerItem?

    var body: some View {
        Form {
            photoPickerSection
            if processedImage != nil {
                Section {
                    Button("Clear") {
                        selectedItem = nil
                        processedImage = nil
                    }
                }
            }
        }
    }

    var photoPickerSection: some View {
        Section("Selected Photo") {
            PhotosPicker(selection: $selectedItem) {
                if let processedImage {
                    processedImage
                        .resizable()
                        .scaledToFit()
                } else {
                    ContentUnavailableView(
                        "No Picture", systemImage: "photo.badge.plus",
                        description: Text("Import a photo to get started")
                    )
                }
            }
            .onChange(of: selectedItem, loadImage)
        }
    }

    func loadImage() {
        Task {
            guard
                let imageData = try await selectedItem?.loadTransferable(
                    type: Data.self)
            else { return }
            guard let inputImage = UIImage(data: imageData) else { return }

            processedImage = Image(uiImage: inputImage)

            let imageSaver = PhotoLibrarySaver()
            imageSaver.writeToPhotoLibrary(image: inputImage)
        }
    }
}

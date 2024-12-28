//
//  VideosPickerView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 23/12/2024.
//

import AVKit
import SwiftUI

struct VideosPickerView: MediaPickerView {
    @State var model = VideosPickerViewModel()

    var body: some View {
        MediaPickerAndAnnotationView(sheetTitle: sheetTitle, model: $model) {
            content
        }
    }

    var sheetTitle: String = "Select Video"

    @ViewBuilder
    var content: some View {
        if let selectedItem = model.selectedItem {
            if case let .loaded(movie) = selectedItem {
                VideoPlayer(player: AVPlayer(url: movie.url))
            } else if case .loading = selectedItem {
                ProgressView()
            }
        }
    }
}

#Preview {
    VideosPickerView()
}

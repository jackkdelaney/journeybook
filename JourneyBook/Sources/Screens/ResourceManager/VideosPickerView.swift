//
//  VideosPickerView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 23/12/2024.
//

import SwiftUI
import AVKit

struct VideosPickerView: SheetView {
    var sheetTitle: String = "Select Video"

    @State internal var model = VideosPickerViewModel()
    
    var content: some View {
        ScrollView {
            ResourcePicker(model: $model)
            if let selectedItem = model.selectedItem {
                switch(selectedItem) {
                case.unknown:
                    Text("Unkown Format")
                case .loading:
                    ProgressView()
                case .loaded(let movie):
                    VideoPlayer(player: AVPlayer(url: movie.url))
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                case .failed:
                    Text("Import failed")
                }
            } else {
                Text("No Item")
            }
        }
        
    }
}

#Preview {
    VideosPickerView()
}

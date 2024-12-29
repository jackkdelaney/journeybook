//
//  ResourceView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 29/12/2024.
//

import SwiftUI
import AVFoundation
import AVKit

struct ResourceView: View {
    var resource: VisualResource

    var body: some View {
        Form {
            if resource.resourceType == .image {
                Section("Photo") {
                    Image(uiImage: UIImage(data: resource.resourceData) ?? UIImage())
                        .resizable()
                        .frame(height: 300)
                        .frame(maxWidth: .infinity)
                        .aspectRatio(contentMode: .fit)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
            if resource.resourceType == .video {
                if let url = resource.resourceData.dataToVideoURL() {
                    Section("Video") {
                        VideoPlayer(player: AVPlayer(url: url))
                            .frame(height: 300)
                            .frame(maxWidth: .infinity)
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                }
            }
        }
        .navigationTitle(resource.aidDescription ?? "Untitled Resource")
        .navigationBarTitleDisplayMode(.inline)
    }
}

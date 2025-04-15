//
//  ResourceSection.swift
//  JourneyBook
//
//  Created by Jack Delaney on 03/01/2025.
//

import AVFoundation
import AVKit
import SharedPersistenceKit
import SwiftUI

struct ResourceSection: View {
    @Bindable var resource: VisualResource

    @ViewBuilder
    var body: some View {
        if resource.resourceType == .image {
            ListDisclosureGroup("Photo", openAtStart: true) {
                ResourceSectionImageViewer(image: UIImage(data: resource.resourceData) ?? UIImage())
            }
        }
        if resource.resourceType == .video {
            if let url = resource.resourceData.dataToVideoURL() {
                Section("Video") {
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(height: 300)
                        .frame(maxWidth: .infinity)
                        .removeListRowPaddingInsets()
                }
            }
        }
    }
}

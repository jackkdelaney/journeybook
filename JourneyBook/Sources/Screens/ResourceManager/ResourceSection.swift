//
//  ResourceSection.swift
//  JourneyBook
//
//  Created by Jack Delaney on 03/01/2025.
//

import SwiftUI

import AVFoundation
import AVKit
import SwiftUI

struct ResourceSection: View {
    var resource: VisualResource

    @ViewBuilder
    var body: some View {
        if resource.resourceType == .image {
            ListDisclosureGroup("Photo",openAtStart: true) {
                Image(uiImage: UIImage(data: resource.resourceData) ?? UIImage())
                    .resizable()
                    .frame(height: 300)
                    .frame(maxWidth: .infinity)
                    .aspectRatio(contentMode: .fit)
                    .removeListRowPaddingInsets()
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

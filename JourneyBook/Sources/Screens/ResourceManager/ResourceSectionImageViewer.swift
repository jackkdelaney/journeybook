//
//  ResourceSectionImageViewer.swift
//  JourneyBook
//
//  Created by Jack Delaney on 15/04/2025.
//

import SwiftUI

//IMPROVED THE GESTURE WITH THE HACKING WITH SWIFT INFO https://www.hackingwithswift.com/quick-start/swiftui/how-to-handle-pinch-to-zoom-for-views


struct ResourceSectionImageViewer: View {
    @State private var currentZoom = 0.0 {
        didSet {
            if currentZoom > 2 {
                currentZoom = 2
            }
        }
    }
    @State private var totalZoom = 1.0
    
    let image: UIImage

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .removeListRowPaddingInsets()
            .scaleEffect(currentZoom + totalZoom)
                        .gesture(
                            MagnifyGesture()
                                .onChanged { value in
                                    currentZoom = value.magnification - 1
                                }
                                .onEnded { value in
                                    totalZoom += currentZoom
                                    currentZoom = 0
                                }
                        )
                        .accessibilityZoomAction { action in
                            if action.direction == .zoomIn {
                                totalZoom += 1
                            } else {
                                totalZoom -= 1
                            }
                        }
    }
}

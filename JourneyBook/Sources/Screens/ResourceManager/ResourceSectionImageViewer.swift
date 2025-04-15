//
//  ResourceSectionImageViewer.swift
//  JourneyBook
//
//  Created by Jack Delaney on 15/04/2025.
//

import SwiftUI

struct ResourceSectionImageViewer: View {
    @State private var scale: CGFloat = 1.0

    let image: UIImage

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .scaleEffect(scale)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        self.scale = value.magnitude
                    }
            )
            .removeListRowPaddingInsets()
            
    }
}

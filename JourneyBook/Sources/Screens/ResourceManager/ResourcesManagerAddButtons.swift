//
//  ResourcesManagerAddButtons.swift
//  JourneyBook
//
//  Created by Jack Delaney on 15/04/2025.
//

import SwiftUI

struct ResourcesManagerAddButtons: View {
    
    @Binding var sheet: ResourcesManagerSheet?

    var body : some View {
        Button {
            sheet = .addPhoto
        } label: {
            Label("Add Photo", systemImage: "photo.artframe")
        }
        Button {
            sheet = .addVideo

        } label: {
            Label("Add Video", systemImage: "film")
        }
    }
    
}

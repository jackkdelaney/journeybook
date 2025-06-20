//
//  ResourceView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 29/12/2024.
//

import SharedPersistenceKit
import SwiftUI

struct ResourceView: View {
    @Bindable var resource: VisualResource

    var body: some View {
        Form {
            ResourceSection(resource: resource)
        }
        .navigationTitle(resource.aidDescription ?? "Untitled Resource")
        .navigationBarTitleDisplayMode(.inline)
    }
}

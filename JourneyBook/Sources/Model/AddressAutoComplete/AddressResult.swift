//
//  AddressResult.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import Foundation

struct AddressResult: Identifiable {
    let id: UUID
    let title: String
    let subtitle: String

    init(id: UUID = UUID(), title: String, subtitle: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
    }
}

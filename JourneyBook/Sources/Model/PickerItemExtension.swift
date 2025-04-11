//
//  PickerItemExtension.swift
//  JourneyBook
//
//  Created by Jack Delaney on 24/12/2024.
//

import Foundation
import SwiftData
import SharedPersistenceKit

extension PickerItem {
    func fetchResources() -> [VisualResource] {
        do {
            return try modelContext.fetch(FetchDescriptor<VisualResource>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func add(_ resource: VisualResource) {
        modelContext.insert(resource)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

//
//  PickerItem.swift
//  JourneyBook
//
//  Created by Jack Delaney on 18/12/2024.
//

import Observation
import PhotosUI
import SwiftData
import SwiftUI

protocol PickerItem: Observable {
    associatedtype Item

    var selectedItem: Item? { get set }
    var selectedPickerItem: PhotosPickerItem? { get set }
    var selectedItemText: String? { get set }

    var filter: PHPickerFilter { get }

    func clearItem()

    var pickerText: String { get }

    var _$observationRegistrar: ObservationRegistrar { get }

    var modelContainer: ModelContainer { get }
    var modelContext: ModelContext { get }

    func saveItem()
}

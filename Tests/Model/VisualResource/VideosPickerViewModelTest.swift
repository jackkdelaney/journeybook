//
//  VideosPickerViewModelTest.swift
//  CommonCodeKit
//
//  Created by Jack Delaney on 14/04/2025.
//

import Foundation
import PhotosUI
import SwiftUI
import Testing

@testable import JourneyBook

struct VideosPickerViewModelTests {
    @MainActor @Test
    func initialisationSetsDefaultPropertiesCorrectly() {
        let model = VideosPickerViewModel()

        #expect(model.selectedItem == nil)
        #expect(model.selectedItemText == nil)
    }

    @MainActor @Test
    func setSelectedItemTextManaully() {
        let model = VideosPickerViewModel()

        model.selectedItemText = "HOWDY!!"

        #expect(model.selectedItemText == "HOWDY!!")
    }

    @MainActor @Test
    func selectedItemLoading() {
        let model = VideosPickerViewModel()

        model.selectedItem = .loading

        #expect(model.selectedItem == .loading)
    }

    @MainActor @Test
    func selectedItemMockedMovie() {
        let model = VideosPickerViewModel()

        let movieURL = URL(fileURLWithPath: "/mock/path/to/movie.mov")

        model.selectedItem = .loaded(Movie(url: movieURL))

        #expect(model.selectedItem == .loaded(Movie(url: movieURL)))
    }

    @MainActor @Test
    func getLoadedMovieNoMovie() {
        let model = VideosPickerViewModel()
        model.selectedItem = .failed

        if let item = model.selectedItem {
            #expect(item.getLoadedMovie() == nil)

        } else {
            #expect(true == false)
        }
    }

    @MainActor @Test
    func testGetLoadedMovie() {
        let model = VideosPickerViewModel()

        let movieURL = URL(fileURLWithPath: "/mock/path/to/movie.mov")
        let movie = Movie(url: movieURL)
        model.selectedItem = .loaded(movie)

        if let item = model.selectedItem {
            #expect(item.getLoadedMovie() == movie)

        } else {
            #expect(true == false)
        }
    }

    @MainActor @Test
    func selectedItemFailed() {
        let model = VideosPickerViewModel()

        model.selectedItem = .failed

        #expect(model.selectedItem == .failed)
    }

    @MainActor @Test
    func clearItemResetsSelection() {
        let model = VideosPickerViewModel()

        model.selectedItem = .loading
        model.selectedItemText = "HOWDY!!"
        model.clearItem()

        #expect(model.selectedItemText == nil)
    }
}

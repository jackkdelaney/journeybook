//
//  AddTransportRouteViewModelTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 14/04/2025.
//

import Foundation
import SharedPersistenceKit
import SwiftData
import Testing

@testable import JourneyBook

struct AddTransportRouteViewModelTests {
    @MainActor @Test
    func routeNameChange() throws {
        let viewModel = AddTransportRouteViewModel()
        let testRouteName = "Test Route"

        viewModel.routeName = testRouteName

        #expect(viewModel.routeName == testRouteName)
    }

    @MainActor @Test
    func routeUrlChange() throws {
        let viewModel = AddTransportRouteViewModel()
        let testURL = URL(string: "https://example.com")!

        viewModel.url = testURL

        #expect(viewModel.url == testURL)
    }

    @MainActor @Test
    func initialisationSetsDefaultPropertiesCorrectly() {
        let viewModel = AddTransportRouteViewModel()

        #expect(viewModel.routeName == nil)
        #expect(viewModel.url == nil)
    }

    @MainActor @Test
    func notSavableWithDefaultValues() {
        let viewModel = AddTransportRouteViewModel()
        #expect(viewModel.saveable == false)
    }

    @MainActor @Test
    func notSavableWithJustRouteName() {
        let viewModel = AddTransportRouteViewModel()

        viewModel.routeName = "Route Name"

        #expect(viewModel.saveable == false)
    }

    @MainActor @Test
    func notSavableWithJustURL() {
        let viewModel = AddTransportRouteViewModel()

        viewModel.url = URL(string: "https://example.com")!

        #expect(viewModel.saveable == false)
    }

    @MainActor @Test
    func resourcesDontIncreaseWhenNoItemAdded() throws {
        let viewModel = AddTransportRouteViewModel()
        let existingSizeOfResources = existingSizeOfResources(for: viewModel)

        #expect(viewModel.fetchResources().count == existingSizeOfResources)
    }

    @MainActor @Test
    func resourcesDontIncreaseWhenEmptyItemIsAttemptedToBeAdded() throws {
        let viewModel = AddTransportRouteViewModel()
        let existingSizeOfResources = existingSizeOfResources(for: viewModel)

        viewModel.saveItem()

        #expect(viewModel.fetchResources().count == existingSizeOfResources)
    }

    @MainActor @Test
    func resourcesDontIncreaseWhenJustNameHasBeenEntered() throws {
        let viewModel = AddTransportRouteViewModel()
        let existingSizeOfResources = existingSizeOfResources(for: viewModel)

        viewModel.routeName = "Route Name"

        viewModel.saveItem()

        #expect(viewModel.fetchResources().count == existingSizeOfResources)
    }

    @MainActor @Test
    func resourcesDontIncreaseWhenJustURLHasBeenEntered() throws {
        let viewModel = AddTransportRouteViewModel()
        let existingSizeOfResources = existingSizeOfResources(for: viewModel)

        viewModel.url = URL(string: "https://example.com")!

        viewModel.saveItem()

        #expect(viewModel.fetchResources().count == existingSizeOfResources)
    }

    @MainActor @Test
    func resourcesIncreaseByOneItemWhenValidItemIsAdded() throws {
        let viewModel = AddTransportRouteViewModel()
        let existingSizeOfResources = existingSizeOfResources(for: viewModel)

        viewModel.routeName = "Route Name"
        viewModel.url = URL(string: "https://example.com")!

        viewModel.saveItem()

        #expect(viewModel.fetchResources().count == (existingSizeOfResources + 1))
    }

    private func existingSizeOfResources(for viewModel: AddTransportRouteViewModel) -> Int {
        viewModel.fetchResources().count
    }
}

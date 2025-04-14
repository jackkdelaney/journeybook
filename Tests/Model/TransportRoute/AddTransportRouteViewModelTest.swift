//
//  AddTransportRouteViewModelTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 14/04/2025.
//

import Foundation
import Testing
import SharedPersistenceKit

@testable import JourneyBook
import SwiftData

struct AddTransportRouteViewModelTests {
    
    func testSaveItem() async throws {
        let viewModel = await AddTransportRouteViewModel()
        let testRouteName = "Test Route"
        let testURL = URL(string: "https://example.com")!

        viewModel.routeName = testRouteName
        viewModel.url = testURL

        //TODO: NEED TO ADD REST IN HERE.
    }
}



//
//  VisualResourceTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 12/04/2025.
//

import Foundation
import Testing

@testable import SharedPersistenceKit

struct VisualResourceTests {
    @Test
    func initialization() {
        let sampleData = Data([0x00, 0x01, 0x02])
        let resource = VisualResource(resourceData: sampleData, resourceType: .image, aidDescription: "Test Description")

        #expect(resource.id != UUID())
        #expect(resource.resourceData == sampleData)
        #expect(resource.resourceType == .image)
        #expect(resource.aidDescription == "Test Description")
        // #expect(resource.steps.isEmpty)  MARK: RENABLE ONCE STEPS BROUGH BACK!
    }
}

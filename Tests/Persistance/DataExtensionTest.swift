//
//  DataExtensionTest.swift
//  SharedPersistenceKit
//
//  Created by Jack Delaney on 16/04/2025.
//

import Foundation
import Testing

@testable import SharedPersistenceKit

struct DataExtensionTests {
    @Test
    func testMakesUrlWithMockVideo() {
        let videoURL = mockVideo().dataToVideoURL()

        #expect(videoURL != nil)
    }

    private func mockVideo() -> Data {
        Data([0x00])
    }
}

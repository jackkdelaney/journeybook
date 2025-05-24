//
//  AnnotationItemTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 12/04/2025.
//

import Foundation
import Testing

@testable import JourneyBook

struct AnnotationItemTests {
    @Test
    func ensuringInitWorksOK() {
        let item = AnnotationItem(latitude: 54.58189372438181, longitude: -5.9377129461587055)

        #expect(item.latitude == 54.58189372438181)
        #expect(item.longitude == -5.9377129461587055)
    }

    @Test
    func ofcoordinateWithGoodData() {
        let item = AnnotationItem(latitude: 54.58189372438181, longitude: -5.9377129461587055)

        #expect(item.coordinate.latitude == 54.58189372438181)
        #expect(item.coordinate.longitude == -5.9377129461587055)
        #expect(item.coordinateValid == true)
    }

    @Test
    func ofcoordinateWithBadDataLatiude() {
        let item = AnnotationItem(latitude: 54.58189372438181, longitude: -200)

        #expect(item.coordinate.latitude == 54.58189372438181)
        #expect(item.coordinate.longitude == -200)
        #expect(item.coordinateValid == false)
    }
}

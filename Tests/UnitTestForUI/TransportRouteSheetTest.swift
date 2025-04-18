//
//  TransportRouteSheetTest.swift
//  JourneyBookTests
//
//  Created by Jack Delaney on 18/04/2025.
//


import Testing
import SharedPersistenceKit
import SwiftUI

@testable import JourneyBook

struct TransportRouteSheetURLTests {
    @Test
    func testInitialisationSetsPropertiesCorrectly() {
        let url = TransportRouteSheetURL(binding: .constant(nil))
        
        #expect(url.binding.wrappedValue == nil)
    }
    
    @Test
    func testInitialisationSetsPropertiesCorrectlyWithID() {
        let id = UUID()
        let url = TransportRouteSheetURL(id: id, binding: .constant(nil))
        
        #expect(url.binding.wrappedValue == nil)
        #expect(url.id == id)

    }
    
}


struct TransportRouteSheetTests {
    @Test
    func testInitialisationSetsPropertiesCorrectly() {
        let sheetA =  TransportRouteSheet.addRoute
        #expect(sheetA.id == "addRoute")
        
        let url = TransportRouteSheetURL(binding: .constant(nil))
        let sheetB = TransportRouteSheet.getRouteUrl(url)
        #expect(sheetB.id == url.id.uuidString)
    }
}

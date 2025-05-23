//
//  CoordinatorTest.swift
//  JourneyBook
//
//  Created by Jack Delaney on 16/04/2025.
//

import Testing

@testable import JourneyBook

struct CoordinatorTests {
    @Test
    func initialisationSetsPropertiesCorrectlyStatic() {
        let cord = Coordinator.start()
        #expect(Coordinator.activeCoordinator != nil)
        #expect(Coordinator.activeCoordinator?.path == cord.path)
    }

    @Test
    func initialisationSetsPropertiesCorrectly() {
        let cord = Coordinator.start()
        let coordinator = Coordinator()

        #expect(coordinator.path == cord.path)
    }

    @Test
    func testPush() {
        let coordinator = Coordinator()

        let pathLength = coordinator.path.count

        coordinator.push(page: .credits)
        #expect(coordinator.path.count == (pathLength + 1))
    }

    @Test
    func pushThenPop() {
        let coordinator = Coordinator()

        let pathLength = coordinator.path.count

        coordinator.push(page: .credits)
        #expect(coordinator.path.count == (pathLength + 1))
        coordinator.pop()
        #expect(coordinator.path.count == pathLength)
    }

    @Test
    func pushThenPopToRoot() {
        let coordinator = Coordinator()

        let pathLength = coordinator.path.count

        coordinator.push(page: .credits)
        coordinator.push(page: .credits)
        coordinator.push(page: .credits)

        #expect(coordinator.path.count == (pathLength + 3))
        coordinator.popToRoot()
        #expect(coordinator.path.count == 0)
    }
}

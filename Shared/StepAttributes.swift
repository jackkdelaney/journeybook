//
//  ActivityAttributesSample.swift
//  CommonCodeKit
//
//  Created by Jack Delaney on 08/04/2025.
//

import ActivityKit

// BASED OFF https://ashishkakkad.com/2022/09/how-to-setup-your-app-for-dynamic-island-ios-16-1/
public struct StepAttributes: ActivityAttributes {
    public typealias Status = ContentState
    public struct ContentState: Codable, Hashable {
        public var stepNumber: Int
        public var totalSteps: Int

        public var description: String?

        public init(stepNumber: Int, totalSteps: Int, description: String?) {
            self.stepNumber = stepNumber
            self.totalSteps = totalSteps
            self.description = description
        }
    }

    public init() {}
}

/*
 public import Foundation
 import ActivityKit

 struct PizzaDeliveryAttributes: ActivityAttributes {
     public typealias PizzaDeliveryStatus = ContentState

     public struct ContentState: Codable, Hashable {
         var driverName: String
         var deliveryTimer: ClosedRange<Date>
     }

     var numberOfPizzas: Int
     var totalAmount: String
     var orderNumber: String
 }
 */

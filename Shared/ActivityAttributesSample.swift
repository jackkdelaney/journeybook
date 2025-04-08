//
//  ActivityAttributesSample.swift
//  JourneyBook-shared
//
//  Created by Jack Delaney on 08/04/2025.
//

import ActivityKit

public struct ActivityAttributesSample: ActivityAttributes {
    public typealias Status = ContentState
    public struct ContentState: Codable, Hashable {
        public var value: String
        
        public init(value: String) {
            self.value = value
        }
    }
    
    public init() {
    }
}

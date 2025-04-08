//
//  ActivityAttributesSample.swift
//  CommonCodeKit
//
//  Created by Jack Delaney on 08/04/2025.
//

import ActivityKit

//BASED OFF https://ashishkakkad.com/2022/09/how-to-setup-your-app-for-dynamic-island-ios-16-1/
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

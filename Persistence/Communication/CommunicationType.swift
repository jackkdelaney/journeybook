//
//  CommunicationType.swift
//  JourneyBook
//
//  Created by Jack Delaney on 11/03/2025.
//

public enum CommunicationType: Codable, CaseIterable {
    case phone, email, message
}

public extension CommunicationType {
    var stringName: String {
        switch self {
        case .phone:
            "Phone Number"
        case .email:
            "Email"
        case .message:
            "Message"
        }
    }
}

//
//  CommunicationType.swift
//  JourneyBook
//
//  Created by Jack Delaney on 11/03/2025.
//

enum CommunicationType: Codable {
    case phone, email, message
}

extension CommunicationType {
    var stringName : String {
        switch(self) {
        case .phone:
            "Phone Number"
        case .email:
            "Email"
        case .message:
            "Message"
        }
    }
}

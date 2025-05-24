//
//  CommunicationViewModelError.swift
//  JourneyBook
//
//  Created by Jack Delaney on 12/03/2025.
//

import Foundation

enum CommunicationViewModelError: Error, Identifiable {
    var id: String {
        "\(hashValue)"
    }

    case noTitleText
    case noPhoneNumber
    case noEmailOrMessage
    case noPhoneOrmessage
}

extension CommunicationViewModelError {
    var errorMessage: String {
        switch self {
        case .noTitleText:
            "Please enter a title."
        case .noPhoneNumber:
            "Please enter a Phone Number"
        case .noEmailOrMessage:
            "Please check you have entered a email and messsage."
        case .noPhoneOrmessage:
            "Please check you have entered a phone number and messsage."
        }
    }
}

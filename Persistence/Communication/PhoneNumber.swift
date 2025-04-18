//
//  PhoneNumber.swift
//  JourneyBook
//
//  Created by Jack Delaney on 11/03/2025.
//

import Foundation

public struct PhoneNumber: Codable {
    public var countryCode: CountryWithCode?

    public var phoneNumber: String

    public var formattedPhoneNumber: String {
        return "+\(countryCode?.dialCode ?? "")\(phoneNumber)"
    }

    public init(countryCode: CountryWithCode? = nil, phoneNumber: String = "") {
        self.countryCode = countryCode
        self.phoneNumber = phoneNumber
    }
}

extension PhoneNumber : Equatable {
    public static func == (lhs: PhoneNumber, rhs: PhoneNumber) -> Bool {
        return lhs.countryCode == rhs.countryCode && lhs.phoneNumber == rhs.phoneNumber
    }
}

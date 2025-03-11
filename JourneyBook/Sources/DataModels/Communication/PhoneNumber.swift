//
//  PhoneNumber.swift
//  JourneyBook
//
//  Created by Jack Delaney on 11/03/2025.
//

import Foundation

struct PhoneNumber: Codable {
    var countryCode: CountryCodes.CountryWithCode
    var phoneNumber: String

    var formattedPhoneNumber: String {
        return "(\(countryCode.dialCode))\(phoneNumber)"
    }
}



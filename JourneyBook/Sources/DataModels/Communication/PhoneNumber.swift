//
//  PhoneNumber.swift
//  JourneyBook
//
//  Created by Jack Delaney on 11/03/2025.
//

import Foundation

struct PhoneNumber: Codable {
    var countryCode: CountryWithCode?
    var phoneNumber: String

    var formattedPhoneNumber: String {
        return "(\(countryCode?.dialCode ?? "UNKOWN"))\(phoneNumber)"
    }

    init(countryCode: CountryWithCode? = nil, phoneNumber: String) {
        self.countryCode = countryCode
        self.phoneNumber = phoneNumber
    }
}

extension PhoneNumber {
    static var examplePhoneNumber: PhoneNumber {
        return PhoneNumber(countryCode: CountryWithCode.example, phoneNumber: "7700900461")
    }
}

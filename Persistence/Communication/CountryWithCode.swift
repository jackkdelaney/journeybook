//
//  CountryWithCode.swift
//  SharedPersistenceKit
//
//  Created by Jack Delaney on 16/04/2025.
//

import Foundation

public struct CountryWithCode: Codable, Identifiable {
    public private(set) var countryCode: String
    public private(set) var countryName: String
    public private(set) var dialCode: String

    public var dialCodeInt: Int {
        Int(dialCode) ?? 0
    }

    public var id: String {
        "\(countryCode)-\(countryName)-\(dialCode)"
    }
}

extension CountryWithCode: Equatable {
    public static func == (lhs: CountryWithCode, rhs: CountryWithCode) -> Bool {
        return lhs.countryCode == rhs.countryCode && lhs.countryName == rhs.countryName && lhs.dialCode == rhs.dialCode
    }
}

public extension CountryWithCode {
    static var example: CountryWithCode {
        CountryWithCode(countryCode: "GB", countryName: "United Kingdom", dialCode: "44")
    }
}

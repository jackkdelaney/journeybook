//
//  Communication.swift
//  JourneyBook
//
//  Created by Jack Delaney on 11/03/2025.
//

import Foundation
import SwiftData

@Model
public class Communication: Identifiable {
    public private(set) var id: UUID
    public private(set) var dateCreated: Date
    public private(set) var dateModified: Date

    private var _title: String
    private var _phoneNumber: PhoneNumber?

    private var _emailAddress: String?
    private var _message: String?

    private var _communictionType: CommunicationType

    @Relationship(deleteRule: .nullify, inverse: \JourneyStep.communication) public var steps: [JourneyStep]

    @Transient public var title: String {
        get { return _title }
        set {
            _title = newValue
            dateModified = Date.now
        }
    }

    @Transient public var phoneNumber: PhoneNumber? {
        get { return _phoneNumber }
        set {
            _phoneNumber = newValue
            dateModified = Date.now
        }
    }

    @Transient public var emailAddress: String? {
        get { return _emailAddress }
        set {
            _emailAddress = newValue
            dateModified = Date.now
        }
    }

    @Transient public var message: String? {
        get { return _message }
        set {
            _message = newValue
            dateModified = Date.now
        }
    }

    @Transient public var communictionType: CommunicationType {
        get { return _communictionType }
        set {
            _communictionType = newValue
            dateModified = Date.now
        }
    }

    public init(id: UUID = UUID(), dateCreated: Date = Date.now, dateModified: Date = Date.now, communictionType: CommunicationType, title: String, phoneNumber: PhoneNumber? = nil, emailAddress: String? = nil, message: String? = nil, steps: [JourneyStep] = []) {
        self.id = id
        self.dateCreated = dateCreated
        self.dateModified = dateModified
        self.steps = steps
        _communictionType = communictionType
        _title = title
        _phoneNumber = phoneNumber
        _emailAddress = emailAddress
        _message = message
    }

    public convenience init(title: String, phoneNumber: PhoneNumber) {
        self.init(
            communictionType: .phone,
            title: title,
            phoneNumber: phoneNumber
        )
    }

    public convenience init(title: String, phoneNumber: PhoneNumber, message: String) {
        self.init(
            communictionType: .message,
            title: title,
            phoneNumber: phoneNumber,
            message: message
        )
    }

    public convenience init(title: String, email: String, message: String) {
        self.init(
            communictionType: .message,
            title: title,
            emailAddress: email,
            message: message
        )
    }
}

extension Communication {
    public static func sampleCommunication() -> Communication {
        Communication(title: "bob",email: "message",message: "message")
    }
}

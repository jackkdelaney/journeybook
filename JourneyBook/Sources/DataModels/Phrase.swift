//
//  Phrase.swift
//  JourneyBook
//
//  Created by Jack Delaney on 29/12/2024.
//

import Foundation
import SwiftData

@Model
class Phrase: Identifiable {
    private(set) var id: UUID
    private(set) var dateCreated: Date
    private(set) var dateModified: Date

    private var _text: String

    @Transient var text: String {
        get { return _text }
        set {
            _text = newValue
            dateModified = Date.now
        }
    }
    
    @Relationship(inverse: \JourneyStep.phrases) var steps: [JourneyStep]


    init(text: String, id: UUID = UUID(), dateCreated: Date = Date.now, dateModified: Date = Date.now, steps: [JourneyStep] = []) {
        self.id = id
        self.dateCreated = dateCreated
        _text = text
        self.dateModified = dateModified
        self.steps = steps
    }
}

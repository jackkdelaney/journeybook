//
//  Phrase.swift
//  JourneyBook
//
//  Created by Jack Delaney on 29/12/2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Phrase: Identifiable {
    private(set) var id: UUID
    private(set) var dateCreated: Date
    private(set) var dateModified: Date

    private var _text: String

    private var _colour: String

    private var _fontSize: FontSizes

    @Transient var text: String {
        get { return _text }
        set {
            _text = newValue
            dateModified = Date.now
        }
    }

    @Transient var fontSize: FontSizes {
        get { return _fontSize }
        set {
            _fontSize = newValue
            dateModified = Date.now
        }
    }

    @Transient var colour: Color {
        get { return Color(hex: _colour) ?? .yellow }
        set {
            if let newValueCheckedAndHex = newValue.toHex() {
                _colour = newValueCheckedAndHex
                dateModified = Date.now
            }
        }
    }

    @Relationship(inverse: \JourneyStep.phrases) var steps: [JourneyStep]

    init(
        text: String,
        colour: Color,
        fontSize: FontSizes = .body,
        id: UUID = UUID(),
        dateCreated: Date = Date.now,
        dateModified: Date = Date.now,
        steps: [JourneyStep] = []
    ) {
        self.id = id
        self.dateCreated = dateCreated
        _text = text
        self.dateModified = dateModified
        self.steps = steps
        _colour = colour.toHex() ?? "#269cc2"
        _fontSize = fontSize
    }
}

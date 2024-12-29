//
//  Phrase.swift
//  JourneyBook
//
//  Created by Jack Delaney on 29/12/2024.
//

import Foundation
import SwiftData

@Model
class Phrase : Identifiable {
    private(set) var id: UUID
    private(set) var dateCreated: Date
    private(set) var dateModified: Date
    var text: String {
        didSet {
            dateModified = Date.now()
        }
    }
    
    init(text: String, id: UUID = UUID(), dateCreated: Date = Date.now, dateModified: Date = Date.now) {
        self.id = id
        self.dateCreated = dateCreated
        self.text = text
        self.dateModified = dateModified
    }
    
}

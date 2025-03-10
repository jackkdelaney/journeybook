//
//  FontSizes.swift
//  JourneyBook
//
//  Created by Jack Delaney on 10/03/2025.
//

import Foundation
import SwiftUI

enum FontSizes: Int, CaseIterable, Codable {
    case caption2 = 0
    case caption = 1
    case footnote = 2
    case body = 3
    case subheadline = 4
    case callout = 5
    case headline = 6
    case title3 = 7
    case title2 = 8
    case title1 = 9
    case largeTitle = 10
}

extension FontSizes {
    var fontStyle: Font {
        switch self {
        case .largeTitle:
            .largeTitle
        case .title1:
            .title
        case .title2:
            .title2
        case .title3:
            .title3
        case .headline:
            .headline
        case .subheadline:
            .subheadline
        case .body:
            .body
        case .callout:
            .callout
        case .footnote:
            .footnote
        case .caption:
            .caption
        case .caption2:
            .caption2
        }
    }
}

//
//  GliderTimeTableSheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import SwiftUI

enum GliderTimeTableSheet: Identifiable, Hashable {
    var id: Self {
        return self
    }

    case showTimeTable(ATCOFile, String, String, Double, Double)
}

extension GliderTimeTableSheet {
    @ViewBuilder
    func buildView() -> some View {
        switch self {
        case let .showTimeTable(atcoFile, atcoString, commonName, lat, long):
            TimeTableSheetView(atcoFile: atcoFile, atcoString: atcoString, commonName: commonName, lat: lat, long: long)
        }
    }
}

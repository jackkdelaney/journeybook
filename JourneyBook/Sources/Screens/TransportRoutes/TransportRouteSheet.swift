//
//  TransportRouteSheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import SwiftUI

enum TransportRouteSheet: Identifiable {
    var id: Self {
        return self
    }

    case addRoute
}

extension TransportRouteSheet {
    @ViewBuilder
    func buildView() -> some View {
        switch self {
        case .addRoute: AddTransportRouteView()
        }
    }
}

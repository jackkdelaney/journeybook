//
//  TransportRouteSheet.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import SwiftUI

struct TransportRouteSheetURL: Identifiable {
    var id = UUID()
    var binding: Binding<URL?>
}

enum TransportRouteSheet: Identifiable {
    var id: String {
        switch self {
        case .addRoute:
            "addRoute"
        case let .getRouteUrl(binding):
            binding.id.uuidString
        }
    }

    case addRoute
    case getRouteUrl(TransportRouteSheetURL)
}

extension TransportRouteSheet {
    @ViewBuilder
    func buildView() -> some View {
        switch self {
        case .addRoute: AddTransportRouteView()
        case let .getRouteUrl(binding):
            WebViewer(selectedService: binding.binding)
        }
    }
}

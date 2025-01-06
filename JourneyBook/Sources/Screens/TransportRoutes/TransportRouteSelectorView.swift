//
//  TransportRouteSelectorView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 06/01/2025.
//

import SwiftData
import SwiftUI

struct TransportRouteSelectorView: View {
    @Query var routes: [TransportRoute]

    @Binding var selectedRoute: TransportRoute?
    var body: some View {
        List {
            ForEach(routes) { route in
                HStack {
                    Button {
                        selectedRoute = route

                    } label: {
                        HStack {
                            Text(route.routeName)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            if selectedRoute == route {
                                Label("Item Selected", systemImage: "checkmark")
                                    .labelStyle(.iconOnly)
                            }
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .navigationTitle("Select a Route")
            }
        }
    }
}

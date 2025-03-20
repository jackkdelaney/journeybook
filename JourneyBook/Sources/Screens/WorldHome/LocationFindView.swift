//
//  LocationFindView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import MapKit
import SwiftUI

struct LocationFindView: SheetView {
    var sheetTitle: String {
        "Location Sheet"
    }

    // https://hackernoon.com/address-autocompletion-using-swiftui-and-mapkit

    @StateObject var viewModel: LocationFindContentViewModel = .init()
    @FocusState private var isFocusedTextField: Bool

    @Binding var selectedLocation: CLLocationCoordinate2D?

    @Environment(\.dismiss) var dismiss

    var confirmButton: some View {
        Button("Confirm") {
            dismiss()
        }
    }

    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField("Type address", text: $viewModel.searchableText)
                .padding()
                .autocorrectionDisabled()
                .focused($isFocusedTextField)
                .font(.title2)
                .onReceive(
                    viewModel.$searchableText.debounce(
                        for: .seconds(1),
                        scheduler: DispatchQueue.main
                    )
                ) {
                    viewModel.searchAddress($0)
                }
                .overlay {
                    ClearTextLineButton(text: $viewModel.searchableText)
                        .padding(.trailing)
                        .padding(.top, 8)
                }
                .onAppear {
                    isFocusedTextField = true
                }

            List(self.viewModel.results) { address in
                AddressRow(selectedLocation: $selectedLocation, address: address)
                // .listRowBackground(.blue)
            }
            // .listStyle(.plain)
            // .scrollContentBackground(.hidden)
        }
        // .background(.blue)
        .edgesIgnoringSafeArea(.bottom)
    }
}

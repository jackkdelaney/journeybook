//
//  AddressRow.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import MapKit
import SwiftUI

struct AddressRow: View {
    @Binding var selectedLocation: CLLocationCoordinate2D?

    let address: AddressResult

    var body: some View {
        NavigationLink {
            ClassicMapView(address: address, selectedLocation: $selectedLocation)
        } label: {
            VStack(alignment: .leading) {
                Text(address.title)
                Text(address.subtitle)
                    .font(.caption)
            }
        }
        .padding(.bottom, 2)
    }
}

private struct ClassicMapView: View {
    @StateObject private var viewModel: MapViewModel

    @Environment(\.dismiss) var dismiss

    @Binding var selectedLocation: CLLocationCoordinate2D?

    private let address: AddressResult

    private let title: String

    init(address: AddressResult, selectedLocation: Binding<CLLocationCoordinate2D?>) {
        self.address = address
        _viewModel = StateObject(wrappedValue: MapViewModel())
        _selectedLocation = selectedLocation
        title = address.title
    }

    private var cameraBinding: Binding<MapCameraPosition> {
        Binding(
            get: {
                .region(viewModel.region)
            },
            set: { newValue in
                if let region = newValue.region {
                    viewModel.region = region
                }
            }
        )
    }

    var body: some View {
        Map(position: cameraBinding) {
            ForEach(viewModel.annotationItems, id: \.id) { item in
                Marker(title, coordinate: item.coordinate)
            }
        }
        .onAppear {
            viewModel.getPlace(from: address, with: $selectedLocation)
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                confirmButton
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }

    var confirmButton: some View {
        Button("Confirm") {
            dismiss()
            dismiss()
        }
        // .disabled(selectedLocation == nil)
    }
}

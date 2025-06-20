//
//  LocationFindContentViewModel.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import Foundation
import MapKit

class LocationFindContentViewModel: NSObject, ObservableObject {
    @Published private(set) var results: [AddressResult] = []
    @Published var searchableText = ""

    private lazy var localSearchCompleter: MKLocalSearchCompleter = {
        let completer = MKLocalSearchCompleter()
        completer.delegate = self
        return completer
    }()

    func searchAddress(_ searchableText: String) {
        guard searchableText.isEmpty == false else { return }
        localSearchCompleter.queryFragment = searchableText
    }
}

extension LocationFindContentViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        Task { @MainActor in
            results = completer.results.map {
                AddressResult(title: $0.title, subtitle: $0.subtitle)
            }
        }
    }

    func completer(_: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
}

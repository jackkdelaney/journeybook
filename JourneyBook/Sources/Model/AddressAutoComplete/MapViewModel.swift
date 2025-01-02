//
//  MapViewModel.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion()
    @Published private(set) var annotationItems: [AnnotationItem] = []

    func getPlace(from address: AddressResult, with selectedLocation : Binding<CLLocationCoordinate2D?>) {
        let request = MKLocalSearch.Request()
        let title = address.title
        let subTitle = address.subtitle

        request.naturalLanguageQuery = subTitle.contains(title)
            ? subTitle : title + ", " + subTitle

        Task {
            let response = try await MKLocalSearch(request: request).start()
            await MainActor.run {
                self.annotationItems = response.mapItems.map {
                    selectedLocation.wrappedValue = $0.placemark.coordinate

                    return AnnotationItem(
                        latitude: $0.placemark.coordinate.latitude,
                        longitude: $0.placemark.coordinate.longitude
                    )
                    
                }
                
                

                self.region = response.boundingRegion
            }
        }
    }
}

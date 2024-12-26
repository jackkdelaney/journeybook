//
//  MapView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 26/12/2024.
//

import SwiftUI
import MapKit

// VERY GOOD GUIDE
//https://www.hackingwithswift.com/books/ios-swiftui/integrating-mapkit-with-swiftui


struct MapView: View {
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    var body: some View {
        Map(position: $position)

    }
}

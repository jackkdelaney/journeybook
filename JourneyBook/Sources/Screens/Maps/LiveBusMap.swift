//
//  MapView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 26/12/2024.
//

import CoreLocation
import MapKit
import SwiftUI

// VERY GOOD GUIDE
// https://www.hackingwithswift.com/books/ios-swiftui/integrating-mapkit-with-swiftui

struct LiveBusMap: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 54.5973, longitude: -5.9301),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    @State private var translinkBusLocations: [TranslinkRealTimeBusLocation] = []
    @StateObject var irelandViewModel = BusEireannVehicleViewModel()

    @State private var isLoading = true

    @ObservedObject var locationViewModel = LocationViewModel()
    
    var busLocation : [any RealTimeBusLocation] {
        let flattenArray : [any RealTimeBusLocation] = translinkBusLocations + irelandViewModel.vehicles
        
        return Array(flattenArray.prefix(450))
    }
    

    var body: some View {
        VStack {
            Map(position: .constant(.region(region))) {
                ForEach(busLocation, id: \.id) { location in
                    Annotation(
                        location.VehicleIdentifier,
                        coordinate: location.location
                    ) {
                        Image(systemName: "bus")
                            .foregroundStyle(location.busOperator.colour)
                    }
                }
            }
            if let location = locationViewModel.userLocation {
                Text("Latitude: \(location.latitude)")
                Text("Longitude: \(location.longitude)")
            } else {
                Text("Location not available.")
            }
        }
        .overlay {
            if isLoading {
                VStack {
                    ProgressView("Loading buses...")
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                }
                .background(.thickMaterial)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear(perform: fetchBusLocations)
        .onAppear(perform: irelandViewModel.fetchData)
        .onReceive(
            Timer.publish(every: 60, on: .main, in: .common).autoconnect()
        ) { _ in
            fetchBusLocations()
        }
        .onReceive(
            Timer.publish(every: 600, on: .main, in: .common).autoconnect()
        ) { _ in
            irelandViewModel.fetchData()
        }
    }

    func fetchBusLocations() {
        guard
            let url = URL(
                string: "https://vpos.translinkniplanner.co.uk/velocmap/vmi/VMI"
            )
        else { return }
        isLoading = true

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(
                        [TranslinkRealTimeBusLocation].self, from: data)
                    DispatchQueue.main.async {
                        self.translinkBusLocations = decodedData
                        self.isLoading = false
                    }
                } catch {
                    print("Error decoding: \(error)")
                    isLoading = false
                }
            }
        }.resume()
    }
}


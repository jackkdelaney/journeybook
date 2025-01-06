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
// https://vpos.translinkniplanner.co.uk/velocmap/vmi/VMI

struct RealTimeBusLocation: Identifiable, Decodable {
    var id: String {
        return "\(self.ID)"
    }
    
    let ID: String
    let Operator: String
    let JourneyIdentifier: String
    let DayOfOperation: String
    let Delay: Int?
    let MOTCode: Int
    let X: String
    let Y: String
    let Timestamp: String
    let XPrevious: String?
    let YPrevious: String?
    let TimestampPrevious: String?
    let VehicleIdentifier: String
    let RealtimeAvailable: Int
    let LineText: String
    let DirectionText: String

    var location: CLLocationCoordinate2D {
        .init(latitude: Double(Y) ?? 0, longitude: Double(X) ?? 0)
    }

    var busOperator: BusOperator {
        BusOperator.getOperator(for: Operator)
    }

}
enum BusOperator {
    case metro
    case ulsterbus
    case glider
    case other

    var colour: Color {
        switch self {
        case .metro: return .pink
        case .ulsterbus: return .blue
        case .glider: return .purple
        case .other: return .black
        }
    }

    static func getOperator(for busOperator: String) -> BusOperator {
        if busOperator == "Ulsterbus" {
            return BusOperator.ulsterbus
        } else if busOperator == "Glider" {
            return BusOperator.glider
        } else if busOperator == "Metro" {
            return BusOperator.metro
        } else {
            return BusOperator.other
        }

    }
}

struct LiveBusMap: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 54.5973, longitude: -5.9301),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    @State private var busLocations: [RealTimeBusLocation] = []
    @State private var isLoading = true

    @ObservedObject var locationViewModel = LocationViewModel()

    var body: some View {
        VStack {
            Map(position: .constant(.region(region))) {
                ForEach(busLocations) { location in
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
        .onReceive(
            Timer.publish(every: 60, on: .main, in: .common).autoconnect()
        ) { _ in
            fetchBusLocations()
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
                        [RealTimeBusLocation].self, from: data)
                    DispatchQueue.main.async {
                        self.busLocations = decodedData
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

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocationCoordinate2D?
    private var locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        // Request the user to authorize accesing the location when in use
        locationManager.requestWhenInUseAuthorization()
        // Try to start updating location if already authorized
        locationManager.startUpdatingLocation()
    }

    func locationManager(
        _: CLLocationManager, didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        // Update published variable with user location coordinates
        userLocation = location.coordinate
    }

    func locationManager(
        _: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            // If authorization status has changed to authorized
            // start updating location
            locationManager.startUpdatingLocation()
        }
    }
}

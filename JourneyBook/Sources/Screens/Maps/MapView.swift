//
//  MapView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 26/12/2024.
//

import MapKit
import SwiftUI

// VERY GOOD GUIDE
// https://www.hackingwithswift.com/books/ios-swiftui/integrating-mapkit-with-swiftui

struct BusLocations: Identifiable {
    var id: String
    var atcoCode: String
    var commonName: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var easting: String
    var northing: String

    init(id: String, atcoCode: String, commonName: String, latitude: String, longitude: String, easting: String, northing: String) {
        self.id = id
        self.atcoCode = atcoCode
        self.commonName = commonName
        self.latitude = CLLocationDegrees(latitude) ?? 0
        self.longitude = CLLocationDegrees(longitude) ?? 0
        self.easting = easting
        self.northing = northing
    }
}

extension BusLocations {
    static func load(from csvFileLocation: String) -> [BusLocations] {
        guard let filePath = Bundle.main.path(forResource: csvFileLocation, ofType: ".csv") else {
            return []
        }
        var csvContents = [BusLocations]()

        var data = ""
        do {
            data = try String(contentsOfFile: filePath, encoding: .utf8)
        } catch {
            return []
        }

        var rows = data.components(separatedBy: "\n")
        rows.removeFirst()

        for row in rows {
            let csvColumns = row.split(separator: ",")
            let location = BusLocations(id: String(csvColumns[0]), atcoCode: String(csvColumns[1]), commonName: String(csvColumns[2]), latitude: String(csvColumns[3]), longitude: String(csvColumns[4]), easting: String(csvColumns[5]), northing: String(csvColumns[6]))
            csvContents.append(location)
        }
        return csvContents
    }
}

struct GliderHaltButton : View {
    var location : BusLocations
    
    var body : some View {
            VStack {
                Text("\(location.commonName)")
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("GLIDER")
                    .font(.caption2)
                    .fontWeight(.heavy)
                    .padding(2)
                    .background(Color.purple)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .leading)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
    }
}


struct TimeTableSheetView : View {
    var atcoFile: ATCOFile
    
    private let stops_G1 : [ATCOStop]
    private let stops_G2 : [ATCOStop]
    
    private let commonName :String

    init(atcoFile: ATCOFile, atcoString: String,commonName: String) {
        self.atcoFile = atcoFile
        self.commonName = commonName
        self.stops_G1 = atcoFile.getTimetable(for: atcoString, on: "G1").sorted {
            $0.nicePublished_arrival_time < $1.nicePublished_arrival_time
        }
        self.stops_G2 = atcoFile.getTimetable(for: atcoString, on: "G2").sorted {
            $0.nicePublished_arrival_time < $1.nicePublished_arrival_time
        }

    }
    
    var body : some View {
        NavigationStack {
            List {
                if !stops_G1.isEmpty {
                    Section("G1 Services (\(stops_G1.count) Found)") {
                        ForEach(stops_G1) { stop in
                            VStack {
                                Text("Departs at: \(stop.published_arrival_time ?? "--")")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("Arrives at: \(stop.published_departure_time ?? "--")")
                                    .font(.caption)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                }
                if !stops_G2.isEmpty {
                    Section("G2 Services (\(stops_G2.count) Found)") {
                        ForEach(stops_G1) { stop in
                            VStack {
                                Text("Departs at: \(stop.published_arrival_time ?? "--")")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("Arrives at: \(stop.published_departure_time ?? "--")")
                                    .font(.caption)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                            }
                        }
                    }
                }
                
            }
            
            /*
             let record_identity: String
             let location: String?
             let published_arrival_time: String?
             let published_departure_time: String?
             let timing_point_indicator: String?
             let fare_stage_indicator: String?
             let bay_number: String?
             */
//            Table(stops) {
//                TableColumn("Stop Name", value: \.niceLocationString)
//                TableColumn("Arrives", value: \.nicePublished_arrival_time)
//                TableColumn("Departs", value: \.nicePublished_departure_time)
//
//
//            }
//            .tableColumnHeaders(.visible)
                .navigationTitle("Time Table for \(commonName)")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        CancelButton()
                    }
                }
        }
    }
}
enum GliderTimeTableSheet: Identifiable, Hashable {
    var id: Self {
        return self
    }

    case showTimeTable(ATCOFile,String,String)
    
}

extension GliderTimeTableSheet {
    @ViewBuilder
    func buildView() -> some View {
        switch self {
        case let .showTimeTable(atcoFile,atcoString,commonName):
            TimeTableSheetView(atcoFile: atcoFile, atcoString: atcoString,commonName:commonName)
        }
    }
}



struct MapView : View {
    @State private var searchText = ""
    
    let locations = BusLocations.load(from: "november-cords")
    
    
    @State var glider = Glider()

    @State private var sheet : GliderTimeTableSheet?
    


    
    @ViewBuilder
    var content : some View {
        if !glider.isLoading {
            List {
                ForEach(searchResults, id: \.id) { name in
                    Button {
                        if let atco = glider.atcoFile {
                            sheet = .showTimeTable(atco, name.atcoCode,name.commonName)
                        }
                    } label: {
                        GliderHaltButton(location: name)
                            .contentShape(Rectangle())
                    }
                    .chevronButtonStyle()
                }
                if !searchResults.isEmpty {
                    Section {
                    }footer: {
                        Link("Timetable data from Translink open data, 02 January 2025 - Monday 30 June 2025", destination: URL(string: "https://www.opendatani.gov.uk/dataset/metro-timetable-data-valid-from-18-june-until-31-august-2016")!)
                        
                    }
                }
            }
            .sheet(item: $sheet) { item in
                item.buildView()
            }
        } else {
            ProgressView()

        }
    }
    var body: some View {
        content
        .task {
            await glider.loadItems()
        }
        .overlay {
            if searchResults.isEmpty {
                ContentUnavailableView.search
            }
        }
            .navigationTitle("Bus Stops")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)

    }
    
    var searchResults: [BusLocations] {
          if searchText.isEmpty {
              return currartedLocations
          } else {
              return currartedLocations.filter { $0.commonName.contains(searchText) }
          }
      }
    
    var currartedLocations : [BusLocations] {
        if glider.isLoading {
            return locations
        }else {
            if let atco = glider.atcoFile {
                let stopCodes = atco.getAllStopCodes()
                return locations.filter { stopCodes.contains($0.atcoCode) }
            } else {
                return locations
            }
        }
    }
    
}

//struct MapView: View {
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 54.5973, longitude: -5.9301),
//        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    )
//
//    var locations = BusLocations.load(from: "november-cords").prefix(499)
//
//    @ObservedObject var locationViewModel = LocationViewModel()
//
//    var body: some View {
//        VStack {
//            Map(position: .constant(.region(region))) {
//                ForEach(locations) { location in
//                    Annotation(location.commonName, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
//                        Image(systemName: "bus")
//                    }
//                }
//            }
//            if let location = locationViewModel.userLocation {
//                Text("Latitude: \(location.latitude)")
//                Text("Longitude: \(location.longitude)")
//            } else {
//                Text("Location not available.")
//            }
//        }
//    }
//}
//
//import CoreLocation
//
//class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
//    @Published var userLocation: CLLocationCoordinate2D?
//    private var locationManager = CLLocationManager()
//
//    override init() {
//        super.init()
//        print("HOWDY")
//        locationManager.delegate = self
//        // Request the user to authorize accesing the location when in use
//        locationManager.requestWhenInUseAuthorization()
//        // Try to start updating location if already authorized
//        locationManager.startUpdatingLocation()
//    }
//
//    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        // Update published variable with user location coordinates
//        userLocation = location.coordinate
//    }
//
//    func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse || status == .authorizedAlways {
//            // If authorization status has changed to authorized
//            // start updating location
//            locationManager.startUpdatingLocation()
//        }
//    }
//}

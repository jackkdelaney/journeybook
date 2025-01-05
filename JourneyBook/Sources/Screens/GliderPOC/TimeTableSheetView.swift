//
//  TimeTableSheetView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import SwiftUI

struct TimeTableSheetView : View {
    var atcoFile: ATCOFile
    
    private let stops_G1 : [ATCOStop]
    private let stops_G2 : [ATCOStop]
    
    private let commonName :String
    
    private let lat :Double
    private let long : Double

    init(atcoFile: ATCOFile, atcoString: String,commonName: String, lat : Double, long : Double) {
        self.atcoFile = atcoFile
        self.commonName = commonName
        self.stops_G1 = atcoFile.getTimetable(for: atcoString, on: "G1").sorted {
            $0.nicePublished_arrival_time < $1.nicePublished_arrival_time
        }
        self.stops_G2 = atcoFile.getTimetable(for: atcoString, on: "G2").sorted {
            $0.nicePublished_arrival_time < $1.nicePublished_arrival_time
        }
        self.lat = lat
        self.long = long

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
                                Spacer()
                                MiniOpenInMapButton(lat: lat, long: long)
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



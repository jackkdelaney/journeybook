//
//  GliderPOCListView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import SwiftUI

struct GliderPOCListView: View {
    @State private var searchText = ""

    let locations = BusLocations.load(from: "november-cords")

    @State var glider = Glider()

    @State private var sheet: GliderTimeTableSheet?

    @ViewBuilder
    var content: some View {
        if !glider.isLoading {
            List {
                ForEach(searchResults, id: \.id) { name in
                    Button {
                        if let atco = glider.atcoFile {
                            sheet = .showTimeTable(atco, name.atcoCode, name.commonName, name.latitude, name.longitude)
                        }
                    } label: {
                        GliderHaltButton(location: name)
                            .contentShape(Rectangle())
                    }
                    .chevronButtonStyle()
                }
                if !searchResults.isEmpty {
                    Section {} footer: {
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

    var currartedLocations: [BusLocations] {
        if glider.isLoading {
            return locations
        } else {
            if let atco = glider.atcoFile {
                let stopCodes = atco.getAllStopCodes()
                return locations.filter { stopCodes.contains($0.atcoCode) }
            } else {
                return locations
            }
        }
    }
}

//
//  MapDetailView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import SwiftUI

struct MapDetailView: View {
    let location: JourneyStepLocation

    var body: some View {
        MapInDetailView(location: location, locked: false)
            .ignoresSafeArea(edges: .all)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .toolbar {
                if canOpenWazeMaps || canOpenAppleMaps || canOpenGoogleMaps {
                    ToolbarItem(placement: .primaryAction) {
                        Menu {
                            Button {
                                UIApplication.shared.open(appleUrl!, options: [:], completionHandler: nil)
                            } label: {
                                Label("Open in Apple Maps", systemImage: "map")
                            }

                            Button {
                                UIApplication.shared.open(googleUrl!, options: [:], completionHandler: nil)
                            } label: {
                                Label("Open in Gogle Maps", systemImage: "g.square")
                            }

                        } label: {
                            Label("Show in Navigation", systemImage: "mappin.and.ellipse")
                                .labelStyle(.iconOnly)
                        }
                    }
                }
            }

            .navigationBarTitle("Map")
    }

    var canOpenGoogleMaps: Bool {
        UIApplication.shared.canOpenURL(googleUrl!)
    }

    var canOpenAppleMaps: Bool {
        UIApplication.shared.canOpenURL(appleUrl!)
    }

    var canOpenWazeMaps: Bool {
        UIApplication.shared.canOpenURL(wazeUrl!)
    }

    var wazeUrl: URL? {
        URL(string: "waze://?navigation=no&lat=\(location.latitude)&lon=\(location.longitude)")
    }

    var appleUrl: URL? {
        URL(string: "maps://?saddr=&daddr=\(location.latitude),\(location.longitude)")
    }

    var googleUrl: URL? {
        URL(string: "comgooglemaps://?saddr=&daddr=\(location.latitude),\(location.longitude)&directionsmode=driving")
    }
}

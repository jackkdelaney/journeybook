//
//  CreditView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 08/01/2025.
//

import ActivityKit
import CommonCodeKit
import SwiftUI

struct CreditView: View {
    var body: some View {
        Form {
            Section {
                LabeledContent("Developer", value: "Jack Delaney")
                LabeledContent {
                    Link("jackkevindelaney@gmail.com", destination: URL(string: "mailto:jackkevindelaney@gmail.com")!)
                } label: {
                    Text("Contact")
                }

            } header: {
                Text("Developer Contact Details")
            } footer: {
                Text("Please contact by email, or through the TestFlight reporting feature.")
            }
            Section("Dependencies") {
                LabeledContent {
                    Link("MIT License", destination: URL(string: "https://github.com/nmdias/FeedKit/blob/main/LICENSE")!)
                }
                label: {
                    Text("Feedkit")
                }
                LabeledContent {
                    Link("MIT License", destination: URL(string: "https://github.com/tuist/tuist/blob/main/LICENSE.md")!)
                }
                label: {
                    Text("Tuist")
                }
            }

            Section {
                LabeledContent {
                    Link("Open Government Licence", destination: URL(string: "https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/")!)
                }
                label: {
                    Text("Translink")
                }
            } header: {
                Text("Northern Ireland Public Transport API's")
            } footer: {
                Text("Transport Information supplied by Translink Opendata API")
            }

            Section {
                LabeledContent {
                    Link("Usage Policy", destination: URL(string: "https://developer.nationaltransport.ie/usagepolicy")!)
                }
                label: {
                    Text("GTFS Realtime")
                }

            } header: {
                Text("Ireland Public Transport API's")
            } footer: {
                Text("Information for all public transport in Ireland provided by The National Transport Authority, Údarás Náisiúnta Iompair")
            }

            Section("Other Services Used") {
                LabeledContent {
                    Link("Terms of Use", destination: URL(string: "https://www.apple.com/legal/internet-services/maps/terms-en.html")!)
                }
                label: {
                    Text("Maps")
                }
                LabeledContent {
                    Link("Website", destination: URL(string: "https://bustimes.org/")!)
                } label: {
                    Text("Bustimes.org Web Service")
                }

                LabeledContent {
                    Link("API", destination: URL(string: "https://bustimes.org/api")!)
                }
                label: {
                    Text("bustimes.org API")
                }
            }
        }
        .navigationTitle("Credits")
        .navigationBarTitleDisplayMode(.inline)
    }
}

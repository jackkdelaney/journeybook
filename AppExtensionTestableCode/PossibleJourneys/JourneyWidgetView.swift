//
//  JourneyWidgetView.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 13/04/2025.
//

import AppIntents
import SharedPersistenceKit
import SwiftData
import SwiftUI
import WidgetKit

public struct JourneyWidgetView: View {
    public var entry: JourneyProvider.Entry

    @Query(sort: \Journey.dateCreated) var journeys: [Journey]
    @Environment(\.widgetFamily) var family

    public var body: some View {
        showedView
            .containerBackground(for: .widget) {
                Color.pink.opacity(0.86)
            }
    }

    @ViewBuilder
    private var showedView: some View {
        switch entry.type {
        case .ordinary:
            content
        case .placeholder:
            theView(for: Journey.sample())
        case .snapshot:
            theView(for: Journey.sampleNewYork())
        }
    }

    @ViewBuilder
    private var content: some View {
        if let journey = journeys.randomElement() {
            theView(for: journey)
                .widgetURL(URL(string: "journeybookjourney://journey/\(journey.id)"))
        } else {
            VStack {
                Label("No Journey's", systemImage: "point.topright.arrow.triangle.backward.to.point.bottomleft.filled.scurvepath")
                    .font(.title3)
                    .bold()
                    .padding(.bottom, 8)
                Text("Please add a Journey in the JourneyBook App.")
                    .font(.caption)
                Spacer()
            }
        }
    }

    private func theView(for journey: Journey) -> some View {
        VStack(alignment: .leading) {
            Label(journey.journeyName, systemImage: "point.topright.arrow.triangle.backward.to.point.bottomleft.filled.scurvepath")
                .font(.title3)
                .bold()
                .padding(.bottom, 8)
            Text("\(journey.steps.count) \(journey.steps.count == 1 ? "Step" : "Steps")")
                .font(.caption)
            Spacer()
            if let journeyDescription = journey.journeyDescription {
                Text(journeyDescription)
                    .font(.caption2)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }

    public init(entry: JourneyProvider.Entry) {
        self.entry = entry
    }
}

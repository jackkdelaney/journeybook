//
//  JourneyWidgetView.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 13/04/2025.
//

import SwiftUI
import WidgetKit
import SharedPersistenceKit
import SwiftData

struct JourneyWidgetView: View {
    var entry: JourneyProvider.Entry

    @Query(sort: \Journey.dateCreated) var journeys : [Journey]
    @Environment(\.widgetFamily) var family
    
//    var selectedJourney : Journey {
//        
//    }
    
    @ViewBuilder
    var content : some View {
        if let journey = journeys.randomElement() {
            VStack(alignment: .leading) {
                Label(journey.journeyName, systemImage: "point.topright.arrow.triangle.backward.to.point.bottomleft.filled.scurvepath")
                    .font(.title3)
                    .bold()
                    .padding(.bottom, 8)
                Text("\(journey.steps.count) Steps")
                    .font(.caption)
                Spacer()
                if let journeyDescription = journey.journeyDescription {
                    Text(journeyDescription)
                        .font(.caption2)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
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
    
    
    @ViewBuilder var showedView : some View {
        Text("")
    }
    var body: some View {
        showedView
        .containerBackground(for: .widget) {
            Color.pink.opacity(0.86)
        }
    }
}

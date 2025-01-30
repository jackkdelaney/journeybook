//
//  WaterWidgetView.swift
//  JourneyBookWidgetExtension
//
//  Created by Jack Delaney on 16/01/2025.
//

import SwiftUI
import WidgetKit

struct TrafficWatchWidgetView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            Label("Road Conditions", systemImage: symbol)
                .font(.title3)
                .bold()
                .padding(.bottom, 8)

            Text(issues)
                .font(.caption)

            Spacer()
            Text("**Last Update:** \(entry.date.formatted(.dateTime))")
                .font(.caption2)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .foregroundStyle(.white)
        .containerBackground(for: .widget) {
            Color.yellow
        }
    }

    private var issues: AttributedString {
        if entry.placeholder || !entry.hasIssues {
            "No Issues Reported"
        } else {
            AttributedString("^[\(entry.issues) issue](inflect: true) reported.")
        }
    }

    private var symbol: String {
        if entry.hasIssues {
            "car.rear.and.collision.road.lane"
        } else {
            "road.lanes"
        }
    }
}

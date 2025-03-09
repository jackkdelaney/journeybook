//
//  RSSContentView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import SwiftUI

struct RSSContentView: View {
    @State var feedManager = RSSFeedManager()

    let feedURL: String = "https://rss.trafficwatchni.com/trafficwatchni_roadworks_rss.xml"

    var body: some View {
        Group {
            if !feedManager.isLoading {
                ListDisclosureGroup("Northern Ireland Roadworks") {
                    RSSContentViewContent(feedManager: $feedManager)
                }

            } else {
                EmptyView()
            }
        }

        .onAppear {
            if !feedManager.hasItems {
                Task {
                    await feedManager.fetchFeed(from: feedURL)
                }
            }
        }
    }
}

struct RSSContentViewContent: View {
    @Binding var feedManager: RSSFeedManager

    @EnvironmentObject private var coordinator: Coordinator

    var body: some View {
        if !feedManager.isLoading {
            ForEach(feedManager.feedItems) { item in
                Button {
                    coordinator.push(page: .rssFeedItem(item))
                } label: {
                    VStack(alignment: .leading) {
                        Text(item.title ?? "No Title")
                            .font(.headline)
                        Text(item.pubDate?.formatted() ?? "No Date")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        if let description = item.description {
                            if let markdown = convertCDATAHTMLToMarkdown(html: description) {
                                Text(markdown)
                                    .font(.caption)
                                    .lineLimit(2)
                            }
                        }
                    }
                }
                .chevronButtonStyle(compact: true)
            }

        } else if let error = feedManager.error {
            Text("Error: \(error.localizedDescription)")
                .foregroundColor(.red)
        }
    }

    func convertCDATAHTMLToMarkdown(html: String) -> AttributedString? {
        var processedHTML = html

        processedHTML = processedHTML.replacingOccurrences(of: "<![CDATA[", with: "")
        processedHTML = processedHTML.replacingOccurrences(of: "]]>", with: "")

        let replacements: [String: String] = [
            "<p>": "\n\n",
            "</p>": "\n",
            "<br />": "\n",
            "<strong>": "**",
            "</strong>": "**",
            "<em>": "*",
            "</em>": "*",
            "&nbsp;": " ",
            "&#xfeff;": "", // Remove zero-width space
            "<span style=\"color:black\">": "",
            "</span>": "",
            "<strong style=\"color:black\">": "**",
            "<em style=\"color:black\">": "*",
            "style=\"color:black\"": "",
        ]

        for (key, value) in replacements {
            processedHTML = processedHTML.replacingOccurrences(of: key, with: value)
        }

        processedHTML = processedHTML.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)

        processedHTML = processedHTML.trimmingCharacters(in: .whitespacesAndNewlines)

        do {
            return try AttributedString(markdown: processedHTML)
        } catch {
            return nil
        }
    }
}

//
//  RSSFeedDetailView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import SwiftUI

struct RSSFeedDetailView: View {
    let item: RSSFeedItem

    var body: some View {
        Form {
            if let date = item.pubDate {
                LabeledContent("Date", value: date.formatted())
            }

            if let link = item.link {
                Link(destination: URL(string: link)!) {
                    LabeledContent("Link", value: link)
                }
            }
            if let description = item.description {
                if let cleanDescription = convertCDATAHTMLToMarkdown(html: description) {
                    Section("Description") {
                        Text(cleanDescription)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
        }
        .navigationTitle(item.title ?? "Unknown Title")
        .navigationBarTitleDisplayMode(.inline)
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

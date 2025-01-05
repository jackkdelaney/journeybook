import SwiftUI
import FeedKit

struct RSSFeedItem: Identifiable {
    let id = UUID()
    let title: String?
    let link: String?
    let description: String?
    let pubDate: Date?
}

extension RSSFeedItem: Equatable,Hashable {
    static func ==(lhs: RSSFeedItem, rhs: RSSFeedItem) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        if let title {
            hasher.combine(title)
        }
    }
}

@Observable
class RSSFeedManager {
    var feedItems: [RSSFeedItem] = []
    var isLoading: Bool = false
    var error: Error?

    var hasItems : Bool {
        !feedItems.isEmpty
    }
    
    func fetchFeed(from urlString: String) async {
        guard let url = URL(string: urlString) else {
            self.error = NSError(domain: "Invalid URL", code: 0)
            return
        }

        self.isLoading = true
        self.error = nil

        let parser = FeedParser(URL: url)
        let result = parser.parse()

        switch result {
        case .success(let feed):
            switch feed {
            case .rss(let rssFeed):
                self.feedItems = rssFeed.items?.compactMap { item in
                    RSSFeedItem(
                        title: item.title,
                        link: item.link,
                        description: item.description,
                        pubDate: item.pubDate
                    )
                } ?? []
            case .atom(let atomFeed):
                self.feedItems = atomFeed.entries?.compactMap { entry in
                    RSSFeedItem(
                        title: entry.title,
                        link: entry.links?.first?.attributes?.href,
                        description: entry.summary?.value,
                        pubDate: entry.published
                    )
                } ?? []
            case .json(let jsonFeed):
                self.feedItems = jsonFeed.items?.compactMap { item in
                    RSSFeedItem(
                        title: item.title,
                        link: item.url,
                        description: item.contentHtml ?? item.contentText,
                        pubDate: item.datePublished
                    )
                } ?? []
            }

        case .failure(let error):
            print("Feed parsing error: \(error)")
            self.error = error
            self.feedItems = []
        }
        self.isLoading = false
    }
}

import Down

struct RSSContentView : View {
    @State var feedManager = RSSFeedManager()
    
  let  feedURL: String = "https://rss.trafficwatchni.com/trafficwatchni_roadworks_rss.xml"


    var body : some View {
        Group {
            if !feedManager.isLoading {
                Section("Northern Ireland Roadworks") {
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
    @Binding var feedManager : RSSFeedManager
    
    @EnvironmentObject private var coordinator: Coordinator


    var body: some View {
                if !feedManager.isLoading {
                    List {
                        ForEach(feedManager.feedItems) { item in
                                VStack(alignment: .leading) {
                                    Text(item.title ?? "No Title")
                                        .font(.headline)
                                    Text(item.pubDate?.formatted() ?? "No Date")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .lineLimit(1)
                                    if let description = item.description {
                                       if let markdown = convertCDATAHTMLToMarkdown(html: description) {
                                            Text(markdown)
                                        }
                                    }
                                 
                                

                                }
                            }
                        .listStyle(PlainListStyle())
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    
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
            "&#xfeff;": "",  // Remove zero-width space
            "<span style=\"color:black\">": "",
            "</span>": "",
            "<strong style=\"color:black\">": "**",
            "<em style=\"color:black\">": "*",
            "style=\"color:black\"": ""
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


struct RSSFeedDetailView : View {
    
    let item : RSSFeedItem
    
    var body: some View {
        Form {
            if let date = item.pubDate {
                LabeledContent("Date", value: date.formatted() )

            }
            if let description = item.description {
                LabeledContent("Description", value: description)

            }
            if let link = item.link {
                Link(destination: URL(string: link)!) {
                    LabeledContent("Link", value: link)
                }
                
            }
            

        }
        .navigationTitle(item.title ?? "Unknown Title")
    }
}

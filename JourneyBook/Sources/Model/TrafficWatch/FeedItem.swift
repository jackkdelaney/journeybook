import SwiftUI
import FeedKit

struct RSSFeedItem: Identifiable {
    let id = UUID()
    let title: String?
    let link: String?
    let description: String?
    let pubDate: Date?
}

@Observable
class RSSFeedManager {
    var feedItems: [RSSFeedItem] = []
    var isLoading: Bool = false
    var error: Error?

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

struct RSSContentView: View {
    @State var feedManager = RSSFeedManager()
    @State private var feedURL: String = "https://rss.trafficwatchni.com/trafficwatchni_roadworks_rss.xml"

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter RSS Feed URL", text: $feedURL)
                    .padding()
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)

                Button("Fetch Feed") {
                    Task {
                        await feedManager.fetchFeed(from: feedURL)
                    }
                }
                .padding()
                .disabled(feedManager.isLoading)

                if feedManager.isLoading {
                    ProgressView()
                } else if let error = feedManager.error {
                    Text("Error: \(error.localizedDescription)")
                        .foregroundColor(.red)
                } else {
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
                                       // HTMLTextView(html: description)
                                        Text(description)
                                    }
                                    HTMLStringView(htmlContent: "<h1>This is HTML String</h1>")

                                }
                            }
                        
                    }
                }
            }
            .navigationTitle("RSS Reader")
        }
    }
    
   
    
}


import WebKit
import SwiftUI

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}

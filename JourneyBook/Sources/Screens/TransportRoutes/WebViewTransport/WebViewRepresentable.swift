//
//  WebView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 06/01/2025.
//
import SwiftUI
import WebKit

struct WebView: View {
    @StateObject private var webViewStore = WebViewStore()

    let url: URL
    var body: some View {
        WebViewRepresentable(url: url, webViewStore: webViewStore)
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("Timetable")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        webViewStore.reload()
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }

                ToolbarItemGroup(placement: .primaryAction) {
                    Button(action: {
                        webViewStore.goBack()
                    }) {
                        Image(systemName: "chevron.left")
                    }
                    .disabled(!webViewStore.canGoBack)

                    Button(action: {
                        webViewStore.goForward()
                    }) {
                        Image(systemName: "chevron.right")
                    }
                    .disabled(!webViewStore.canGoForward)
                }
            }
    }
}

private struct WebViewRepresentable: UIViewRepresentable {
    let url: URL
    @ObservedObject var webViewStore: WebViewStore

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webViewStore.webView = webView
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_: WKWebView, context _: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebViewRepresentable

        init(_ parent: WebViewRepresentable) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish _: WKNavigation?) {
            parent.webViewStore.canGoBack = webView.canGoBack
            parent.webViewStore.canGoForward = webView.canGoForward
        }
    }
}

private class WebViewStore: ObservableObject {
    @Published var canGoBack = false
    @Published var canGoForward = false
    var webView: WKWebView?

    func goBack() {
        webView?.goBack()
    }

    func goForward() {
        webView?.goForward()
    }

    func reload() {
        webView?.reload()
    }
}

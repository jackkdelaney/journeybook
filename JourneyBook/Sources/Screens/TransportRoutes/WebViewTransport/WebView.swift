//
//  WebView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import SwiftUI
@preconcurrency import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    let onConfirm: (URL) -> Void
    @Binding var canGoBack: Bool
    @Binding var isNonBustimePage: Bool
    @Binding var currentURL: URL?

    @Binding var webView: WKWebView

    func makeCoordinator() -> WebCoordinator {
        WebCoordinator(self, canGoBack: $canGoBack, isNonBustimePage: $isNonBustimePage, currentURL: $currentURL, onConfirm: onConfirm)
    }

    func makeUIView(context: Context) -> WKWebView {
        // let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_: WKWebView, context _: Context) {}

    class WebCoordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: WebView
        @Binding var canGoBack: Bool
        @Binding var isNonBustimePage: Bool
        @Binding var currentURL: URL?
        var onConfirm: (URL) -> Void

        init(_ parent: WebView, canGoBack: Binding<Bool>, isNonBustimePage: Binding<Bool>, currentURL: Binding<URL?>, onConfirm: @escaping (URL) -> Void) {
            self.parent = parent
            _canGoBack = canGoBack
            _isNonBustimePage = isNonBustimePage
            _currentURL = currentURL
            self.onConfirm = onConfirm
        }

        func webView(_ webView: WKWebView, didFinish _: WKNavigation!) {
            canGoBack = webView.canGoBack
            if let url = webView.url?.absoluteString {
                isNonBustimePage = !url.contains("bustimes.org")
                if url.contains("bustimes.org/services/") {
                    currentURL = webView.url!
                } else {
                    currentURL = nil
                }
            }
        }
    }
}

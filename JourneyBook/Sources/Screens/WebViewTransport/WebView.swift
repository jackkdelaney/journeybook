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
    let onConfirm: (String) -> Void
    @Binding var canGoBack: Bool
    @Binding var isNonBustimePage: Bool
    @Binding var currentURL: String?
    
    
    @Binding var webView: WKWebView

    func makeCoordinator() -> WebCoordinator {
        WebCoordinator(self, canGoBack: $canGoBack, isNonBustimePage: $isNonBustimePage, currentURL: $currentURL, onConfirm: onConfirm)
    }

    func makeUIView(context: Context) -> WKWebView {
        //let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }

    class WebCoordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: WebView
        @Binding var canGoBack: Bool
        @Binding var isNonBustimePage: Bool
        @Binding var currentURL: String?
        var onConfirm: (String) -> Void

        init(_ parent: WebView, canGoBack: Binding<Bool>, isNonBustimePage: Binding<Bool>, currentURL: Binding<String?>, onConfirm: @escaping (String) -> Void) {
            self.parent = parent
            self._canGoBack = canGoBack
            self._isNonBustimePage = isNonBustimePage
            self._currentURL = currentURL
            self.onConfirm = onConfirm
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            canGoBack = webView.canGoBack
            if let url = webView.url?.absoluteString {
                isNonBustimePage = !url.contains("bustimes.org")
                if url.contains("bustimes.org/services/") {
                    currentURL = url
                } else {
                    currentURL = nil
                }
            }
        }
    }
}

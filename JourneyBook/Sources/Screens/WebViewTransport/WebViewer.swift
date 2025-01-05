//
//  WebViewer.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import SwiftUI
import WebKit

import SwiftUI
import WebKit



struct WebViewer: View {
    @State private var selectedService: String? = nil
    @State private var showingWebView = false
    @State private var currentURL: String? = nil
    @State private var canGoBack = false
    @State private var isNonBustimePage = false
    @State private var webView: WKWebView? = nil
    
    var body: some View {
        VStack {
            if let service = selectedService {
                Text("Selected Service: \(service)")
                    .padding()
            } else {
                Text("No service selected")
                    .padding()
            }

            Button("Go to Bus Times") {
                showingWebView = true
            }
        }
        .sheet(isPresented: $showingWebView) {
            NavigationView {
                WebView(url: URL(string: "https://bustimes.org/regions/NI")!, onConfirm: { selectedURL in
                    selectedService = selectedURL
                    showingWebView = false
                }, canGoBack: $canGoBack, isNonBustimePage: $isNonBustimePage, currentURL: $currentURL)
                .navigationBarItems(
                    leading: HStack {
                        if canGoBack && isNonBustimePage {
                            Button("Back") {
                                webView?.goBack()
                            }
                        }
                        Button("Cancel") {
                            showingWebView = false
                        }
                    },
                    trailing: Button("Confirm") {
                        if let url = currentURL {
                            selectedService = url
                            showingWebView = false
                        }
                    }.disabled(currentURL == nil)
                )
            }
        }
    }
}

//
//  WebWelcomerView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import SwiftUI
import WebKit

struct WebWelcomerView: View {
    @Binding var selectedService: URL?
    @State private var showingWebView = false
    @State private var currentURL: URL? = nil
    @State private var canGoBack = false
    @State private var isNonBustimePage = false
    @State private var webView = WKWebView()

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
                LimitedWebView(url: URL(string: "https://bustimes.org/regions/NI")!, onConfirm: { selectedURL in
                    selectedService = selectedURL
                    showingWebView = false
                }, canGoBack: $canGoBack, isNonBustimePage: $isNonBustimePage, currentURL: $currentURL, webView: $webView)
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            HStack {
                                if canGoBack && isNonBustimePage {
                                    Button {
                                        webView.goBack()
                                    } label: {
                                        Label("Backward", systemImage: "arrowshape.backward.circle")
                                            .labelStyle(.iconOnly)
                                    }
                                } else {
                                    EmptyView()
                                }

                                Spacer()
                                Button {
                                    webView.reload()
                                } label: {
                                    Label("Refresh", systemImage: "arrow.clockwise")
                                        .labelStyle(.iconOnly)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                Spacer()
                                if canGoBack && isNonBustimePage {
                                    Button {
                                        webView.goForward()
                                    } label: {
                                        Label("Forward", systemImage: "arrowshape.forward.circle")
                                            .labelStyle(.iconOnly)
                                    }
                                }
                            }
                        }
                    }
                    .navigationBarItems(
                        leading: HStack {
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

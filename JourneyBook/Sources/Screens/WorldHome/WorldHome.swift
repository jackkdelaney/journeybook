//
//  WorldHome.swift
//  JourneyBook
//
//  Created by Jack Delaney on 26/12/2024.
//

import SwiftData
import SwiftUI

struct WorldHome: View {
    @Environment(\.accessibilityAssistiveAccessEnabled) private var isAssistiveAccessEnabled

    @EnvironmentObject private var coordinator: Coordinator

    @State var sheet: JourneySheet? = nil

    @State var searchText = ""

    var body: some View {
        List {
            if searchText.isEmpty {
                AddNewJoruneyButton(sheet: $sheet)
            }
            JourneyItemsView(
                sheet: $sheet,
                searchText: $searchText
            )
            if searchText.isEmpty {
                AdvertButton(title: "Live Bus Locations", tagLine: "See bus locations live.", appPage: .mapExperience, symbol: "map.circle.fill")
                RSSContentView(feedURL: "https://rss.trafficwatchni.com/trafficwatchni_roadworks_rss.xml", for: "Northern Ireland Roadworks")
            }
        }
        .navigationTitle("JourneyBook")
        .navigationBarTitleDisplayMode(displayMode)
        .searchable(text: $searchText, prompt: Text("Search Journey's"))
        .sheet(item: $sheet) { item in
            item.buildView()
        }
        .toolbar {
            toolbar
        }
        .liveJourneyControls()
    }

    private var displayMode: NavigationBarItem.TitleDisplayMode {
        if isAssistiveAccessEnabled {
            NavigationBarItem.TitleDisplayMode.inline
        } else {
            NavigationBarItem.TitleDisplayMode.automatic
        }
    }

    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        if isAssistiveAccessEnabled {
            acessibleToolbar
        } else {
            standardToolBar
        }
    }

    @ToolbarContentBuilder
    private var acessibleToolbar: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            Button {
                coordinator.push(page: .credits)
            } label: {
                Label("Credits", systemImage: "info.circle")
            }
            .labelStyle(.titleAndIcon)
            Spacer()

            Button {
                coordinator.push(page: .acessblityHomeToolbarOptions)

            } label: {
                Label("Options", systemImage: "case")
            }
            .labelStyle(.titleAndIcon)
        }
    }

    @ToolbarContentBuilder
    private var standardToolBar: some ToolbarContent {
        ToolbarItemGroup(placement: .primaryAction) {
            Button {
                coordinator.push(page: .credits)
            } label: {
                Label("Credits", systemImage: "info.circle")
            }
            Menu {
                WorldHomeNavigationButtons()
            } label: {
                Label("Options", systemImage: "case")
            }
        }
    }
}


extension SwiftUI.View {
    func asViewController() -> UIViewController {
          let vc = UIHostingController(rootView: self)
          vc.view.frame = UIScreen.main.bounds
          return vc
      }
}

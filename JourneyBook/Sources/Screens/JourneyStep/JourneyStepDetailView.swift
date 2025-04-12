//
//  JourneyStepDetailView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import AVFAudio
import SwiftUI
import SharedPersistenceKit

struct JourneyStepDetailView: View {
    @EnvironmentObject private var coordinator: Coordinator

    @Bindable var step: JourneyStep
    @AppStorage("storedVoice") var storedVoice: String = ""

    @State private var sheet: JourneySheet? = nil

    var body: some View {
        Form {
            if let location = step.location {
                OpenInMapsButton(location: location)
            }
            visualResourcesSections
            communicationSection
            transitSection
            phrasesSection
        }
        .safeAreaInset(edge: .top) {
            locationSection
        }
        .safeAreaInset(edge: .bottom) {
            if let stepDescription = step.stepDescription {
                Text(stepDescription)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .padding(.bottom)
                    .background(
                        Rectangle()
                            .fill(.blue)
                            .overlay(.thinMaterial)
                    )
                    .ignoresSafeArea(edges: .bottom)
                    .ignoresSafeArea(edges: .bottom)
            }
        }
        .navigationTitle("\(step.stepName)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    sheet = .editJourneyStep(step)
                } label: {
                    Text("Edit")
                }
            }
        }
        .sheet(item: $sheet) { item in
            item.buildView()
        }
    }

    @ViewBuilder
    private var visualResourcesSections: some View {
        if step.visualResources.isEmpty {
            Text("No Visual Resource")
        } else {
            ForEach(step.visualResources) { resource in
                ResourceSection(resource: resource)
                if let aid = resource.aidDescription {
                    Section("Resource Aid Description") {
                        Text(aid)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var transitSection: some View {
        if let transport = step.route {
            Section("Route Timetable") {
                Button {
                    coordinator.push(page: .webpage(transport.url))
                } label: {
                    Label("View Timetable for \(transport.routeName)", systemImage: "bus.doubledecker.fill")
                }
            }
        }
    }

    @ViewBuilder
    private var locationSection: some View {
        if let location = step.location {
            Button {
                coordinator.push(page: .mapDetails(location))
            } label: {
                MapInDetailView(location: location)
                    .ignoresSafeArea(edges: .top)
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
            }
        }
    }

    @ViewBuilder
    var phrasesSection: some View {
        if !step.phrases.isEmpty {
            Section("Phrases") {
                ForEach(step.phrases) { phrase in
                    Button {
                        coordinator.push(page: .phraseDetails(phrase))
                    } label: {
                        phraseButton(for: phrase)
                    }
                    .chevronButtonStyle(compact: true)
                }
            }
        }
    }
    
    @ViewBuilder
    var communicationSection : some View {
        if let communication = step.communication {
            Section("Communication") {
                Button {
                    coordinator.push(page: .communicationDetail(communication))
                } label: {
                    HStack {
                        VStack {
                            Text(communication.title)
                                .frame(maxWidth:.infinity,alignment: .leading)
                            Text(communication.communictionType.stringName)
                                .font(.caption)
                                .frame(maxWidth:.infinity,alignment: .leading)
                        }
                        if communication.communictionType == .phone, let phoneNumber = communication.phoneNumber{
                            Text(phoneNumber.formattedPhoneNumber)
                                .frame(maxWidth:.infinity,alignment: .trailing)
                        }
                        
                    }
                }
                .chevronButtonStyle()
            }
        }
    }

    @ViewBuilder
    private func phraseButton(for phrase: Phrase) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(phrase.text)")
                    .font(.headline)
                    .lineLimit(2)
                Text(phrase.dateCreated.formatted())
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .frame(
                        maxWidth: .infinity, alignment: .leading
                    )
            }
        }
    }
}

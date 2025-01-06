//
//  JourneyStepDetailView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import SwiftUI
import AVFAudio

struct JourneyStepDetailView: View {
    @EnvironmentObject private var coordinator: Coordinator

    @Bindable var step: JourneyStep
    @AppStorage("storedVoice") var storedVoice: String = ""
    
    @State var voice: AVSpeechSynthesisVoice? = nil
    
    let speaker = Speaker()


    var body: some View {
        Form {
            if let location = step.location {
                OpenInMapsButton(location: location)
            }
            if let resource = step.visualResource {
                ResourceSection(resource: resource)
                if let aid = resource.aidDescription {
                    Section("Resource Aid Description") {
                        Text(aid)
                    }
                }
            } else {
                Text("No Visual Resource")
            }
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
    }

    @ViewBuilder
    private var transitSection : some View {
        if let transport = step.route {
            Section("Route Timetable") {
                Button {
                    coordinator.push(page: .webpage(transport.url))
                }label: {
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
        } else {
            Text("No location added")
        }
    }
    
    @ViewBuilder
    var phrasesSection : some View {
        if !step.phrases.isEmpty {
            Section("Phrases") {
                ForEach(step.phrases) { phrase in
                    Button {
                        try? speaker.speak(phrase.text, voice: voice)
                    } label: {
                        Label(phrase.text,systemImage: "play.circle")
                    }
                }
            }
            .onAppear {
                if storedVoice != "" {
                    voice = AVSpeechSynthesisVoice(identifier: storedVoice)
                }
            }
        }
    }
    

    
    
      
}

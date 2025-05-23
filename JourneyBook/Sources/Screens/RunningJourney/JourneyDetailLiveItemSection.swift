//
//  JourneyDetailLiveItemSection.swift
//  CommonCodeKit
//
//  Created by Jack Delaney on 11/04/2025.
//

import SharedPersistenceKit
import SwiftUI

extension View {
    func liveJourneyControls() -> some View {
        modifier(LiveJourneyControlButtons())
    }
}

struct LiveJourneyControlButtons: ViewModifier {
    @State private var model: LiveJourneyStepModel = .init()

    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom) {
                if let theLiveJourney = model.theLiveJourney {
                    VStack {
                        Text("\(model.stepNumber) of \(theLiveJourney.stepsAmount)")
                        HStack {
                            Button {
                                model.goBack()
                            } label: {
                                Label("Last Step", systemImage: "arrowshape.left.circle")
                            }
                            .disabled(model.disableLastButton)

                            Button {
                                model.goForward()
                            } label: {
                                Label("Next Step", systemImage: "arrowshape.right.circle")
                            }
                            .disabled(model.disableNextButton)
                        }
                    }
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .padding(.bottom)
                    .background(
                        Rectangle()
                            .fill(.purple)
                            .overlay(.thinMaterial)
                    )
                    .ignoresSafeArea(edges: .bottom)
                    .ignoresSafeArea(edges: .bottom)
                    //                if let stepDescription = step.stepDescription {
                    //                    Text(stepDescription)

                    //                }
                }
            }
    }
}

struct JourneyDetailLiveItemSection: View {
    @Bindable var journey: Journey

    @State private var model: LiveJourneyStepModelWithinJourney

    init(journey: Journey) {
        self.journey = journey
        model = LiveJourneyStepModelWithinJourney(journey: journey)
    }

    var body: some View {
        Section {
            if model.journeyNotLive {
                Button {
                    model.makeNewLiveJourney()
                } label: {
                    Text("Run this journey")
                }
            } else {
                Button {
                    model.endJourneys()
                } label: {
                    Text("End Journey")
                }
            }
        } footer: {
            Text("Your Live Journey will be shown in your devices's Dynamic Island or Lock Screen as a Live Activity.")
        }
    }
}

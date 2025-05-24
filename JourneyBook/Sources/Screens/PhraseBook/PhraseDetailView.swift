//
//  PhraseDetailView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 10/03/2025.
//

import SharedPersistenceKit
import SwiftUI

struct PhraseDetailView: View {
    @Environment(\.modelContext) private var modelContext

    @State var model: CurrentPhraseViewModel

    init(phrase: Phrase) {
        model = CurrentPhraseViewModel(phrase: phrase)
    }

    var body: some View {
        VStack {
            scroolingViewBox
                .padding(.top)
            stepperView
            Spacer()
            playButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(model.colour)
        .navigationTitle("Phrase Details")
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                ColorPicker(
                    "Change Background Colour", selection: $model.colour
                )
                .labelsHidden()
            }
        }
    }

    private var playButton: some View {
        SinglePressButtonForSpeak(
            text: $model.text,
            showImage: false
        ) {
            HStack(alignment: .center) {
                Image(systemName: "play")
                    .font(.largeTitle)
                Text("Play")
                    .font(.headline)
            }
            .padding([.top, .bottom])
            .padding([.top, .bottom])
            .frame(maxWidth: .infinity)
            .frame(minWidth: 70, idealWidth: 250)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .shadow(radius: 3)
            .padding([.leading, .trailing], 20)
        }
        .buttonStyle(.plain)
    }

    private var stepperView: some View {
        VStack(alignment: .center) {
            Stepper("Font Size", value: $model.fontSizeAsInt, in: 0 ... 10)
                .labelsHidden()
                .padding(.top)
            HStack(alignment: .center) {
                Text("Smaller")
                    .font(.caption2)
                Spacer()
                Text("Larger")
                    .font(.caption)
            }
            .padding([.leading, .trailing])
            Divider()
            Text("Text Size")
                .font(.footnote)
                .fontWeight(.bold)
                .padding(.bottom)
        }
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .shadow(radius: 3)
        .padding([.leading, .trailing], 20)
    }

    private var scroolingViewBox: some View {
        ScrollView {
            Text(model.text)
                .font(model.fontSize.fontStyle)
                .fontWeight(.regular)
        }
        .contentMargins(1, for: .scrollContent)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 300)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .shadow(radius: 3)
        .padding([.leading, .trailing], 20)
    }
}

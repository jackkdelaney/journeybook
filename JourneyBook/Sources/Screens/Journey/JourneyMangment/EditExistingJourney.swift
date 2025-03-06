//
//  EditExistingJourney.swift
//  JourneyBook
//
//  Created by Jack Delaney on 03/02/2025.
//

import SwiftData
import SwiftUI

struct EditExistingJourney: SheetView {
    @Bindable var journey: Journey
    @State private var errorMessage: JourneyViewModelError?

    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var journeyName: String
    @State private var journeyDescription: String?

    init(journey: Journey) {
        self.journey = journey
        journeyName = journey.journeyName

        _journeyName = State(initialValue: journey.journeyName)
        _journeyDescription = State(initialValue: journey.journeyDescription)
    }

    var sheetTitle: String {
        "Edit Journey"
    }

    var content: some View {
        Form {
            Section("Journey Name") {
                TextField("Journey Name", text: $journeyName)
            }
            Section("Journey Description") {
                TextEditor(text: journeyDescriptionUnWrapped)
            }
        }
        .alert(item: $errorMessage) { error in
            Alert(title: Text("Could Not Save"), message: Text(error.errorMessage), dismissButton: .cancel())
        }
    }

    var confirmButton: some View {
        Button("Add") {
            do {
                if journeyName.isEmpty {
                    throw JourneyViewModelError.noJourneyText
                }
                journey.journeyName = journeyName
                journey.journeyDescription = journeyDescription
                try modelContext.save()
                dismiss()
            } catch JourneyViewModelError.noJourneyText {
                errorMessage = .noJourneyText
            } catch {
                print(error)
            }
        }
    }

    private var journeyDescriptionUnWrapped: Binding<String> {
        Binding(
            get: {
                journeyDescription ?? ""
            },
            set: {
                if $0.isEmpty || $0 == "" {
                    journeyDescription = nil
                } else {
                    journeyDescription = $0
                }
            }
        )
    }
}

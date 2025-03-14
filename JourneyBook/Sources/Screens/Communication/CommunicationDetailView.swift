//
//  CommunicationDetailView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 12/03/2025.
//

import SwiftUI

struct CommunicationDetailView: View {
    @Bindable var communication: Communication

    @State private var sheet: CommunicationSheet? = nil

    let inSheet: Bool

    var body: some View {
        if inSheet {
            CommunicationEditSheet(communication: communication)
        } else {
            viewMode
        }
    }

    var viewMode: some View {
        Form {
            specialisedSection
            Section("Communication Details") {
                LabeledContent {
                    Text(communication.dateModified.formatted())
                }
                label: {
                    Text("Last Updated")
                }
                LabeledContent {
                    Text(communication.dateCreated.formatted())
                }
                label: {
                    Text("Created")
                }
                LabeledContent {
                    Text(communication.communictionType.stringName)
                }
                label: {
                    Text("Type")
                }
            }
        }
        .navigationTitle(communication.title)
        .sheet(item: $sheet) { item in
            item.buildView()
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    sheet = .editCommunication(communication)
                } label: {
                    Text("Edit")
                }
            }
        }
    }

    @ViewBuilder
    private var specialisedSection: some View {
        if communication.communictionType == .phone, let phoneNumber = communication.phoneNumber {
            Section("Phone Number Details") {
                phoneNumberView(for: phoneNumber)
            }
        } else if communication.communictionType == .message, let phoneNumber = communication.phoneNumber, let message = communication.message {
            Section(header: Text("Message Details"), footer: Text("You message is \(message.count) characters in length.")) {
                phoneNumberView(for: phoneNumber)
                messsageView(for: message)
            }

            Section {
                Button("Send Messsage") {}
            }
        } else if communication.communictionType == .email, let email = communication.emailAddress, let message = communication.message {
            Section(header: Text("Email Details"), footer: Text("You message is \(message.count) characters in length.")) {
                emailView(for: email)
                messsageView(for: message)

                Button("Send Email") {}
            }
        }
    }

    @ViewBuilder
    private func phoneNumberView(for phoneNumber: PhoneNumber) -> some View {
        LabeledContent {
        Link(phoneNumber.formattedPhoneNumber, destination: URL(string: "tel://\(phoneNumber.formattedPhoneNumber)")!)
        }
        label: {
            Text("Phone Number")
        }
    }

    @ViewBuilder
    private func messsageView(for message: String) -> some View {
        Text(message)
            .multilineTextAlignment(.leading)
    }

    @ViewBuilder
    private func emailView(for email: String) -> some View {
        LabeledContent {
            Link(email, destination: URL(string: "")!)
        }
        label: {
            Text("Email")
        }
    }
}

/*
 LabeledContent {
     Link("MIT License", destination: URL(string: "https://github.com/nmdias/FeedKit/blob/main/LICENSE")!)
 }
 label: {
     Text("Feedkit")
 }
 */
/*
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

 */

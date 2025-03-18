//
//  MessageButtonView.swift
//  JourneyBook
//
//  Created by Jack Delaney on 18/03/2025.
//

import MessageUI
import Messages
import UIKit
import SwiftUI

fileprivate class MessagesUIKitViewController: UIViewController,
    MFMessageComposeViewControllerDelegate
{

    var delegate: MessageUIKitViewDelegate?
    var recipients: [String]?
    var body: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func displayMessageInterface() {

        let controller = MFMessageComposeViewController()
        controller.messageComposeDelegate = self
        
        controller.body = body ?? ""
        controller.recipients = self.recipients ?? []
        
        self.present(controller, animated: true, completion: nil)

//        if MFMessageComposeViewController.canSendText() {
//            self.present(controller, animated: true, completion: nil)
//        } else {
//            self.delegate?.messageCompletion(result: .failed)
//        }
    }

    func messageComposeViewController(
        _ controller: MFMessageComposeViewController,
        didFinishWith result: MessageComposeResult
    ) {
        controller.dismiss(animated: true)
    }
}

fileprivate protocol MessageUIKitViewDelegate {
    func messageCompletion(result: MessageComposeResult)
}

fileprivate class UIKitMessageCoordinator : NSObject, UINavigationControllerDelegate, MessageUIKitViewDelegate {
    
    var parent : MessageUIView
    
    init(_ controller: MessageUIView) {
        self.parent = controller
    }
    
    func messageCompletion(result: MessageComposeResult) {
        self.parent.presentationMode.wrappedValue.dismiss()
        self.parent.completiton(result)
    }
    
    
}

fileprivate struct MessageUIView : UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var recipients: [String]
    @Binding var body: String
    
    var completiton : ((_ result : MessageComposeResult) -> Void)
    
    func makeCoordinator() -> UIKitMessageCoordinator {
        UIKitMessageCoordinator(self)
    }
    
    func makeUIViewController(context: Context) -> MessagesUIKitViewController {
        let controller = MessagesUIKitViewController()
        controller.delegate = context.coordinator
        controller.recipients = recipients
        controller.body = body
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MessagesUIKitViewController, context: Context) {
        uiViewController.recipients = recipients
        uiViewController.displayMessageInterface()
    }
}


struct MessageButtonView : View {
    
    @State private var showMessageView = false
    
    @State var recipients: [String]
    @State var message : String
    
    
    init(showMessageView: Bool = false, recipients: [String], message: String) {
        self.showMessageView = showMessageView
        self.recipients = recipients
        self.message = message
    }
    
    var body: some View {
        Button {
            self.showMessageView = true
        } label: {
            Text("Send Message")
        }
        .sheet(isPresented: self.$showMessageView) {
            MessageUIView(recipients: $recipients, body: $message, completiton: handleCompletition)
        }
    }
    
    private func handleCompletition(_ result : MessageComposeResult) {
        switch result {
        case .cancelled:
            print("cancelled")
        case .sent:
            print("sent")
        case .failed:
            print("failed")
        @unknown default:
            print("unkown")
            break
        }
    }
}

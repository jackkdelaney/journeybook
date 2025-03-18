//
//  MailButton.swift
//  JourneyBook
//
//  Created by Jack Delaney on 18/03/2025.
//

import SwiftUI

struct MailButton: View {
    @Environment(\.openURL) private var openUrl
    
    let email : String
    let buttonTitle : String
    let content : String
    
    var body: some View {
        Button(buttonTitle) {
            sendEmail(openUrl: openUrl)
        }
    }
    
    var emailInEmailFormat : String {
        content.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "%20")
    }
    
    
    func sendEmail(openUrl: OpenURLAction) {
        let urlString = "mailto:\(email)?subject=Email%20from%20JourneyBook&body=\(emailInEmailFormat)"
        guard let url = URL(string: urlString) else { return }
        
        openUrl(url) { accepted in
            if !accepted {
                print("Not Vaid for Some Reason")
            }
        }
    }
}

//
//  Glider.swift
//  JourneyBook
//
//  Created by Jack Delaney on 04/01/2025.
//

import Foundation
import Observation

// Observable class to handle JSON loading and state management
@Observable
class Glider {
    var atcoFile: ATCOFile?
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    // Async function to load JSON from a file
    func loadItems() async {
        isLoading = true
        errorMessage = nil
        
        do {
            if let url = Bundle.main.url(forResource: "MPH_Glider_6 Jan2025", withExtension: "json") {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let atcoFile = try decoder.decode(ATCOFile.self, from: data)

                
                // Update items on the main thread
                await MainActor.run {
                    self.atcoFile = atcoFile
                    print("LOADED")
                }
            } else {
                throw URLError(.fileDoesNotExist)
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to load items: \(error.localizedDescription)"
            }
        }
        
        isLoading = false
    }
}


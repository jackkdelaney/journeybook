//
//  BusEireannVehicleViewModel.swift
//  JourneyBook
//
//  Created by Jack Delaney on 07/01/2025.
//

import Foundation

    class BusEireannVehicleViewModel: ObservableObject {
        @Published var vehicles: [BusEireannEntity] = []

        func fetchData() {
            guard let url = URL(string: "https://api.nationaltransport.ie/gtfsr/v2/Vehicles?format=json") else { return }

            var request = URLRequest(url: url)
            let apiKey = ProcessInfo.processInfo.environment["API_KEY_IRELAND"]
            print(apiKey)
            request.setValue(apiKey, forHTTPHeaderField: "x-api-key")

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(BusEireannVehicleData.self, from: data)
                        print(decodedData.entity.count)
                        //DispatchQueue.main.async {
                            self.vehicles = decodedData.entity
                        //}
                        print(self.vehicles.count)
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }.resume()
        }
    }

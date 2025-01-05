//
//  GliderHaltButton.swift
//  JourneyBook
//
//  Created by Jack Delaney on 05/01/2025.
//

import SwiftUI

struct GliderHaltButton : View {
    var location : BusLocations
    
    var body : some View {
            VStack {
                Text("\(location.commonName)")
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("GLIDER")
                    .font(.caption2)
                    .fontWeight(.heavy)
                    .padding(2)
                    .background(Color.purple)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .leading)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
    }
}


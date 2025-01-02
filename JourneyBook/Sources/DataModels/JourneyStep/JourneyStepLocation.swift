//
//  JourneyStepLocation.swift
//  JourneyBook
//
//  Created by Jack Delaney on 02/01/2025.
//

import Foundation
import CoreLocation

struct JourneyStepLocation : Identifiable,Codable, Hashable {
    var id: UUID
    var location: CLLocationCoordinate2D?
    
    init(id: UUID = UUID(), location: CLLocationCoordinate2D) {
        self.id = id
        self.location = location
    }
    
    enum CodingKeys: String, CodingKey {
         case id
         case latitude
         case longitude
     }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        if let location {
            hasher.combine(location.latitude)
            hasher.combine(location.longitude)
        }

    }
    
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            if let location = location {
                try container.encode(location.latitude, forKey: .latitude)
                try container.encode(location.longitude, forKey: .longitude)
            }
        }
        
    init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
          id = try container.decode(UUID.self, forKey: .id)
          if let latitude = try container.decodeIfPresent(CLLocationDegrees.self, forKey: .latitude),
             let longitude = try container.decodeIfPresent(CLLocationDegrees.self, forKey: .longitude) {
              location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
          } else {
              location = nil
          }
      }
    
}



extension JourneyStepLocation {
    static func ==(lhs: JourneyStepLocation, rhs: JourneyStepLocation) -> Bool {
        return lhs.id == rhs.id
    }
}

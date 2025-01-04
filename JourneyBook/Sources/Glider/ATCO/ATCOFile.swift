//
//  ATCOFile.swift
//  JourneyBook
//
//  Created by Jack Delaney on 04/01/2025.
//


struct ATCOFile: Codable {
    let header: ATCOHeader
    let locations: [ATCOLocation]
    let journeys: [String: ATCORoute]
    let unparsed: [ATCOUnparsed]
}

extension ATCOFile: Equatable,Hashable {
    static func == (lhs: ATCOFile, rhs: ATCOFile) -> Bool {
        lhs.header.production_datetime == rhs.header.production_datetime 
     
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(header.production_datetime)
    }
}

extension ATCOFile {
    
    func getTimetable(for atcoCode: String, on service : String) -> [ATCOStop] {
         var timetable: [ATCOStop] = []
         
        for (_, route) in journeys.filter({$0.value.route_number == service}) {
            let matchingStops = route.stops.filter { $0.niceLocationString == atcoCode && $0.published_arrival_time != nil && $0.published_departure_time != nil}
             timetable.append(contentsOf: matchingStops)
         }
         
        for item in timetable {
            print(item.niceLocationString)
            print(item.nicePublished_arrival_time)
        }
         return timetable
     }
    
    func containsLocation(for place: String) -> Bool {
        for (_, route) in journeys {
            if route.stops.contains(where: { $0.location == place }) {
                return true
            }
        }
        return false
    }
    
    func getAllStopCodes() -> Set<String> {
        var stopCodes = Set<String>()
        for (_, route) in journeys {
            for stop in route.stops {
                stopCodes.insert(stop.location ?? "UNKOWN")
            }
        }
        
        return stopCodes
    }
}


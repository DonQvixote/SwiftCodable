import Foundation

public struct FlightPlan: Decodable {
    public var aircraft: Aircraft
    public var route: [String]
    public var flightRules: FlightRules
    
    private var departureDates: [String: Date]
    
    public var proposedDepartureDate: Date? {
        return departureDates["proposed"]
    }
    
    public var actualDepartureDate: Date? {
        return departureDates["actual"]
    }
    
    var remarks: String?
}

extension FlightPlan {
    private enum CodingKeys: String, CodingKey {
        case aircraft
        case flightRules = "flight_rules"
        case route
        case departureDates = "departure_time"
        case remarks
    }
}

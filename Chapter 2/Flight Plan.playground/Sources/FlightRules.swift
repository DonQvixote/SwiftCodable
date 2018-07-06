import Foundation

public enum FlightRules: String, Decodable {
    case visual = "VFR"
    case instrument = "IFR"
}

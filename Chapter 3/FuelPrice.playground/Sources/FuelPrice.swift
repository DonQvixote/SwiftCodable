import Foundation

//public struct FuelPrice {
//    public let type: Fuel
//    public let pricePerLiter: Double
//    public let currency: String
//}
//
//extension FuelPrice {
//    public init(_ other: AmericanFuelPrice) {
//        self.type = other.fuel
//        self.pricePerLiter = other.price
//        self.currency = "USD"
//    }
//}
//
//extension FuelPrice {
//    public init(_ other: CanadianFuelPrice) {
//        self.type = other.type
//        self.pricePerLiter = self.price
//        self.currency = "CAD"
//    }
//}

public protocol FuelPrice {
    var type: Fuel { get }
    var pricePerLiter: Double { get }
    var currency: String { get }
}

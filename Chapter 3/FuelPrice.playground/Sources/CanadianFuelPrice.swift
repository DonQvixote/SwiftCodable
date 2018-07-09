import Foundation

public struct CanadianFuelPrice: Decodable {
    public let type: Fuel
    public let price: Double // 加元/升
}

extension CanadianFuelPrice: FuelPrice {
    public var pricePerLiter: Double {
        return self.price
    }
    
    public var currency: String {
        return "CAD"
    }
}

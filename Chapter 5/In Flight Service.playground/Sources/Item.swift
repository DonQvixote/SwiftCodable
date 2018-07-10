import Foundation

public struct Item: Codable, Hashable, Equatable {
    public var name: String
    public var unitPrice: Int
    
    public init(name: String, unitPrice: Int) {
        self.name = name
        self.unitPrice = unitPrice
    }
    
    public static let peanuts = Item(name: "Peanuts", unitPrice: 200)
    public static let chips = Item(name: "Chips", unitPrice: 300)
    public static let popcorn = Item(name: "Popcorn", unitPrice: 400)
}

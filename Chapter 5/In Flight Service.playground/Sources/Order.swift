import Foundation

public struct Order: Codable {
    private(set) var seat: String
    
    public struct LineItem: Codable {
        public var item: Item
        public var count: Int
        
        public var price: Int {
            return item.unitPrice * count
        }
    }
    
    public private(set) var lineItems: [LineItem]
    
    public let creationDate: Date = Date()
    
    public var totalPrice: Int {
        // for-in 循环
//        var totalPrice = 0
//        for lineItem in lineItems {
//            totalPrice += lineItem.price
//        }
//        return totalPrice
        
        // 函数式编程
        return lineItems.map { $0.price }.reduce(0, +)
    }
    
    public init(seat: String, itemCounts: [Item: Int]) {
        self.seat = seat
        self.lineItems = itemCounts.compactMap { $1 > 0 ? LineItem(item: $0, count: $1) : nil}
        
        // for-in 循环
//        var lineItems: [LineItem] = []
//        for (item, count) in itemCounts {
//            guard count > 0 else { continue }
//            let lineItem = LineItem(item: item, count: count)
//            lineItems.append(lineItem)
//        }
    }
}

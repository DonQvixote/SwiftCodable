import Foundation

public class PremiumEconomySeat: EconomySeat {
    public var mealPreference: String?
    
    private enum CodingKeys: String, CodingKey {
        case mealPreference
    }
    
    public init(number: Int, letter: String, mealPreference: String?) {
        super.init(number: number, letter: letter)
        self.mealPreference = mealPreference
    }
    
    // Decodable 协议需要指定初始化 init(from:), 但不能在拓展中声明，所以在类中能使用 Decodable 的地方非常局限，Class 和 Decodable 兼容性不好
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mealPreference = try container.decodeIfPresent(String.self, forKey: .mealPreference)
        try super.init(from: decoder)
    }
}

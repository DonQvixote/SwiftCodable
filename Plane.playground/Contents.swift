//: Playground - noun: a place where people can play

import Foundation

/* 1. JSON 中的对象是无序键值对，和 Swift 中包含 String 的 Dictionary 类似，
      并可转换为遵从 Codable 协议的类型；
   2. JSON 将数字表示成一系列数，不受任何语义的影响，它不区分整数和浮点数，不区分
      定长和非定长数字，也不区分是二进制还是十进制。每个实现自行决定如何解释这些数字。
      JSONDecoder (及其底层处理程序 JSONSerialization) 使用 NSNumber 解释数字
      值，并可装换为 Swift 标准库中的大多数数字类型。
   3. 对于具有 Optional 属性的类型，Codable 可以自动将 null 映射为 nil.
 */

// typealias Codable = Decodable & Encodable

// 为了适应各种数据交换格式，解码器和编码器都是用名为 容器(container) 的抽象
struct Plane: Codable {
    var manufacturer: String
    var model: String
    var seats: Int
    
    // 创建 CodingKeys 枚举，定义属性名称和容器的键之间的映射
//    private enum CodingKeys: String, CodingKey {
//        case manufacturer
//        case model
//        case seats
//    }
    
    // init(from:) 初始化函数里面创建一个键控容器，调用 decoder 的 container(keyedBy:)方法，并传入 CodingKeys 作为参数
    // 后缀 self 的表示方法允许类型像值一样被使用
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.manufacturer = try container.decode(String.self, forKey: .manufacturer)
//        self.model = try container.decode(String.self, forKey: .model)
//        self.seats = try container.decode(Int.self, forKey: .seats)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.manufacturer, forKey: .manufacturer)
//        try container.encode(self.model, forKey: .model)
//        try container.encode(self.seats, forKey: .seats)
//    }
}

let json = """
{
    "manufacturer": "Cessna",
    "model": "172 Skyhawk",
    "seats": 4,
}
""".data(using: .utf8)!

// MARK: - Decode

let decoder = JSONDecoder()
let plane = try! decoder.decode(Plane.self, from: json)

print(plane.manufacturer)
print(plane.model)
print(plane.seats)

// MARK: - Encode

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
let reencodedJSON = try! encoder.encode(plane)

print(String(data: reencodedJSON, encoding: .utf8)!)

let arrayJSON1 = """
[
    {
        "manufacturer": "Cessna",
        "model": "172 Skyhawk",
        "seats": 4
    },
    {
        "manufacturer": "Piper",
        "model": "PA-28 Cherokee",
        "seats": 4
    }
]
""".data(using: .utf8)!

// 条件一致性 extension Array: Decodable where Element: Decodable
if let planes = try? decoder.decode([Plane].self, from: arrayJSON1) {
    print(planes)
}

let arrayJSON2 = """
{
    "planes": [
        {
            "manufacturer": "Cessna",
            "model": "172 Skyhawk",
            "seats": 4
        },
        {
            "manufacturer": "Piper",
            "model": "PA-28 Cherokee",
            "seats": 4
        }
    ]
}
""".data(using: .utf8)!

// extension Dictionary: Decodable where Key: Decodable, Value: Decodable
struct Fleet: Decodable {
    var planes: [Plane]
}

let fleet = try! decoder.decode(Fleet.self, from: arrayJSON2)
let planes2 = fleet.planes

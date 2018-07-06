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

//: Playground - noun: a place where people can play

import Foundation

// 继承的解析

let json = """
{
    "number": 7,
    "letter": "A",
    "mealPreference": "vegetarian"
}
""".data(using: .utf8)!

let decoder = JSONDecoder()
let seat = try! decoder.decode(PremiumEconomySeat.self, from: json)

print(seat.number)
print(seat.letter)
print(seat.mealPreference!)

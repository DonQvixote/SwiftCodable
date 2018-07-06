//: Playground - noun: a place where people can play

import Foundation

// Web 服务在 JSON 的键中使用 snake_case (蛇形命名法)

let json = """
{
    "aircraft": {
        "identification": "NA12345",
        "color": "Blue/White"
    },
    "flight_rules": "IFR",
    "route": ["KTTD", "KHIO"],
    "departure_time": {
        "proposed": "2018-04-20T14:15:00-0700",
        "actual": "2018-04-20T14:20:00-0700"
    },
    "remarks": null
}
""".data(using: .utf8)!

var decoder = JSONDecoder()
//decoder.keyDecodingStrategy = .convertFromSnakeCase
decoder.dateDecodingStrategy = .iso8601

let plan = try! decoder.decode(FlightPlan.self, from: json)

print(plan.aircraft.identification)
print(plan.actualDepartureDate!)

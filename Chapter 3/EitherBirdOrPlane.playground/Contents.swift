//: Playground - noun: a place where people can play

import Foundation

// 解析未确定的类型

let json = """
[
    {
        "type": "bird",
        "genus": "Chaetura",
        "species": "Vauxi"
    },
    {
        "type": "plane",
        "identifier": "NA12345"
    }
]
""".data(using: .utf8)!

let decoder = JSONDecoder()
let objects = try! decoder.decode([Either<Bird, Plane>].self, from: json)

for object in objects {
    switch object {
    case .left(let bird):
        print("Poo-tee-weet? It's \(bird.genus) \(bird.species)!")
    case .right(let plane):
        print("Vooooooooooooom! It's \(plane.identifier)!")
    }
}

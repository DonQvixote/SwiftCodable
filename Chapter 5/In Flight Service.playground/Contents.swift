//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import XCPlayground

// Xcode 默认会把 CF 和 UI 开头的常量展示诚描述性、本地化的名字
// UserDefaults 是一个分层的持久性进程间（可选分布式使用）的键值存储，为存储用户偏好做了特别优化

guard let url = Bundle.main.url(forResource: "Inventory", withExtension: ".plist") else {
    fatalError("Inventory.plist missing from main bundle")
}

var inventory: [Item]
do {
    let data = try Data(contentsOf: url)
    
    let decoder = PropertyListDecoder()
    let plist = try decoder.decode([String: [Item]].self, from: data)
    inventory = plist["items"]!
} catch {
    fatalError("Cannot load inventory \(error)")
}

var orders: [Order]
let decoder = PropertyListDecoder()
if let data = UserDefaults.standard.object(forKey: "orders") as? Data,
    let savedOrders = try? decoder.decode([Order].self, from: data) {
    orders = savedOrders
} else {
    orders = []
}

let viewController = OrderSelectionViewController()
let navigationController = UINavigationController(rootViewController: viewController)

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = navigationController


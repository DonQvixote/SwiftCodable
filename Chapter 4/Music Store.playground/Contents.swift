//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

// 使用 iTunes Search API 构建音乐商店应用

let viewController = MasterViewController()
let navigationController = UINavigationController(rootViewController: viewController)

viewController.search(for: Music.self, with: "Eminem")

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = navigationController


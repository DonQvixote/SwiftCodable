//
//  AppDelegate.swift
//  InFlightService
//
//  Created by 夏语诚 on 2018/7/10.
//  Copyright © 2018年 Banana. All rights reserved.
//

import UIKit

let defaults = UserDefaults.standard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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
        if let data = defaults.value(forKey: "orders") as? Data,
            let savedOrders = try? decoder.decode([Order].self, from: data) {
            orders = savedOrders
        } else {
            orders = []
        }
        
        let viewController = OrderSelectionViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        
        return true
    }

}


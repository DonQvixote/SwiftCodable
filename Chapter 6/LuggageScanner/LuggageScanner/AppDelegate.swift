//
//  AppDelegate.swift
//  LuggageScanner
//
//  Created by 夏语诚 on 2018/7/10.
//  Copyright © 2018年 Banana. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let context = mainContext()
        
        try! Passenger.insertSampleRecords(into: context)
        
        let scanner = LuggageTagScanner()
        let tagsAtDeparture = [#imageLiteral(resourceName: "tag.png")]
        
        // Departure
        do {
            for image in tagsAtDeparture {
                try scanner.scan(image: image, at: .origin, in: context)
            }
            
            try context.save()
        } catch {
            fatalError("\(error)")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 100.0) {
            do {
                for image in tagsAtDeparture {
                    try scanner.scan(image: image, at: .destination, in: context)
                }
                
                try context.save()
            } catch {
                fatalError("\(error)")
            }
        }
        
        return true
    }
}


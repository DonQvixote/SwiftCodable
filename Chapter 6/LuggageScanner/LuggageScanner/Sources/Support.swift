//
//  Support.swift
//  LuggageScanner
//
//  Created by 夏语诚 on 2018/7/12.
//  Copyright © 2018年 Banana. All rights reserved.
//

import Foundation
import CoreData

private let container: NSPersistentContainer = {
    guard let url = Bundle.main.url(forResource: "BaggageCheck", withExtension: ".mom") else {
        fatalError("BaggageCheck.mom missing from main bundle")
    }
    
    guard let model = NSManagedObjectModel(contentsOf: url) else {
        fatalError("Invalid managed model file")
    }
    
    let container = NSPersistentContainer(name: "BaggageCheck", managedObjectModel: model)
    container.loadPersistentStores { (_, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    return container
}()

func mainContext() -> NSManagedObjectContext {
    let context = container.viewContext
    // 当保存一个 mergePolicy 属性配置为NSMergeByPropertyObjectTrumpMergePolicy 的 NSManagedObjectContext 对象时，持久化存储会自动更新现有的那个与新插入对象的属性具有相同的约束值的对象，同时维持现有的关系不变。
    context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    return context
}

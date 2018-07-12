//
//  Luggage.swift
//  LuggageScanner
//
//  Created by 夏语诚 on 2018/7/11.
//  Copyright © 2018年 Banana. All rights reserved.
//

import Foundation
import CoreData

@objc(Luggage)
final class Luggage: NSManagedObject {
    @NSManaged var identifier: UUID
    @NSManaged var weight: Float
    @NSManaged var departedAt: NSDate?
    @NSManaged var arrivedAt: NSDate?
    
    @NSManaged var owner: Passenger?
}

extension Luggage: Decodable {
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case weight
        case owner
    }
    
    convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            fatalError("Missing context or invalid context")
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Luggage", in: context) else {
            fatalError("Unknown entity Luggage in context")
        }
        
        // NSManagedObject 的指定构造方法 init(entity:insertInto:) 接受的是 NSEntityDescription 类型的参数和可为空的 NSManagedObjectContext 类型参数
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.identifier = try container.decode(UUID.self, forKey: .identifier)
        self.weight = try container.decode(Float.self, forKey: .weight)
        self.owner = try container.decodeIfPresent(Passenger.self, forKey: .owner)
    }
}

extension Luggage {
    static func fetch(with identifier: UUID, from context: NSManagedObjectContext) throws -> Luggage? {
        var luggage: Luggage? = nil
        context.performAndWait {
            let fetchRequest = NSFetchRequest<Luggage>(entityName: "Luggage")
            fetchRequest.predicate = NSPredicate(format: "identifier == &@", identifier as CVarArg)
            fetchRequest.fetchLimit = 1
            if let results = try? context.fetch(fetchRequest) {
                luggage = results.first
            }
        }
        
        return luggage
    }
}

//
//  Plane.swift
//  
//
//  Created by 夏语诚 on 2018/7/6.
//

import Foundation

// typealias Codable = Decodable & Encodable

// 为了适应各种数据交换格式，解码器和编码器都是用名为 容器(container) 的抽象
public struct Plane: Codable {
    public var manufacturer: String
    public var model: String
    public var seats: Int
    
    // 创建 CodingKeys 枚举，定义属性名称和容器的键之间的映射
    //    private enum CodingKeys: String, CodingKey {
    //        case manufacturer
    //        case model
    //        case seats
    //    }
    
    // public init(from:) 初始化函数里面创建一个键控容器，调用 decoder 的 container(keyedBy:)方法，并传入 CodingKeys 作为参数
    // 后缀 self 的表示方法允许类型像值一样被使用
    //    init(from decoder: Decoder) throws {
    //        let container = try decoder.container(keyedBy: CodingKeys.self)
    //        self.manufacturer = try container.decode(String.self, forKey: .manufacturer)
    //        self.model = try container.decode(String.self, forKey: .model)
    //        self.seats = try container.decode(Int.self, forKey: .seats)
    //    }
    //
    // public func encode(to encoder: Encoder) throws {
    //        var container = encoder.container(keyedBy: CodingKeys.self)
    //        try container.encode(self.manufacturer, forKey: .manufacturer)
    //        try container.encode(self.model, forKey: .model)
    //        try container.encode(self.seats, forKey: .seats)
    //    }
}

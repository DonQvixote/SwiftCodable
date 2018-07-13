//: Playground - noun: a place where people can play

import Foundation

// 数据序列化和交换的问题比通过 HTTP 请求 JSON 复杂多了。 目前有带着无数序列而来的 XML。 也有二进制格式 MessagePack、 CBOR 和 BSON。 还有基于模式的机制 Protocol Buffers 和 Avro， 更全面的方案有 RPC 框架，例如 gRPC， Thrift， 以及 SOAP。 即使你只想用自己设计的 HTTP 协议的 JSON， 也可以使用性能优化方案 streaming 和 压缩方案 gzip 或 Brotli。

// JSONEncoder 的实现细节都是 JSONSerialization 通过层层打包解包 NS 对象和 Swift 值来实现的。

/// 类型符合 Encoder 协议的对象，就是 *encoder* 对象。 被传入 `encode(to:)` 方法的参数被要求遵从 `Encodable` 协议。 Encoder 协议要求对 codingPath 和 userInfo 提供读权限， 也需要提供能返回有键容器、无键容器和单值容器的方法。
//protocol Encoder {
//    var codingPath: [CodingKey] { get }
//    var userInfo: [CodingUserInfoKey: Any] { get }
//
//    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key: CodingKey
//    func unkeyedContainer() -> UnkeyedEncodingContainer
//    func singleValueContainer() -> SingleValueEncodingContainer
//}

/// 类型符合 Decoder 协议的对象，就是 decoder 对象。 被传入 init(from:) 初始化方法的参数被要求遵从 Decodable 协议。 Decoder 协议和 Encoder 的要求一样，只不过方法返回的是解码容器而非编码容器。
//protocol Decoder {
//    var codingPath: [CodingKey] { get }
//    var userInfo: [CodingUserInfoKey] { get }
//
//    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key: CodingKey
//    func unkeyedContainer() throws -> UnkeyedDecodingContainer
//    func singleValueContainer() throws -> SingleValueDecodingContainer
//}

// 一个 容器（container） 对象包含一个或多个值。 容器可用于将 Swift 值编码成其表示， 或者用于把解码过的表示初始化成 Swift 值。

// 容器有三种：
//
// 单值容器, 只存储一个可被编码或解码的值
// 非键容器, 存储一系列可被编码或解码的值的集合， 类似于 Array 或 Set
// 键控容器, 存储一系列可被编码或解码的键值对的集合， 类似于 Dictionary

// 容器为特定的交换格式中的数据提供解码编码等基本功能。

// 容器协议需要一些为各种类型提供重载的方法。
// mutating func encodeNil() throws
// mutating func encode<T>(_ value: T) throws where T : Encodable
// 容器还需要这些重载方法的一些变体， 包括用于引用类型的 encodeConditional（_ :) 和 用于键控容器中的可选类型的 encodeIfPresent（_：forKey：）。

struct Plane: Codable {
    var manufacturer: String
    var model: String
    var seats: Int
}

let plane = Plane(manufacturer: "Cirrus", model: "SR22", seats: 4)

let encoder = MessagePackEncoder()
let data = try! encoder.encode(plane)
print(data.map { String(format: "%2X", $0) })

import Foundation

// MessagePack 是一种二进制序列化格式。比 JSON 更快更小，但是难以理解。

// MessagePack 可以把对象进行编码。它第一个字节代表格式，表示对象的类型以及如何解码该值。
// MessagePack 设计上的一个核心特性就是，它如何充分利用一个字节中完整的 255 个值。

protocol MessagePackEncodingContainer {
    var data: Data { get }
}

class _MessagePackEncoder {
    var codingPath: [CodingKey] = []
    
    var userInfo: [CodingUserInfoKey : Any] = [:]
    
    fileprivate var container: MessagePackEncodingContainer?
    
    var data: Data {
        return container?.data ?? Data()
    }
}

extension _MessagePackEncoder: Encoder {
    fileprivate func assertCanCreateContainer() {
        precondition(self.container == nil)
    }
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        assertCanCreateContainer()
        
        let container = KeyedContainer<Key>(codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        
        return KeyedEncodingContainer(container)
    }
    
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        assertCanCreateContainer()
        
        let container = UnkeyedContainer(codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        
        return container
    }
    
    func singleValueContainer() -> SingleValueEncodingContainer {
        assertCanCreateContainer()
        
        let container = SingleValueContainer(codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        
        return container
    }
}

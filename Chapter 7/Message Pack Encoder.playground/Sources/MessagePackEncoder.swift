import Foundation

// 定义一个公开的 MessagePackEncoder 类型为把对象编码为数据提供便携的 API，就像 Foundation 框架中的 JSONEncoder 或 PropertyLisEncoder 那样。

public class MessagePackEncoder {
    public init() {
        
    }
    
    public func encode(_ value: Encodable) throws -> Data {
        let encoder = _MessagePackEncoder()
        try value.encode(to: encoder)
        return encoder.data
    }
}

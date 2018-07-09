import Foundation

public struct Coordinate: Decodable {
    public var latitude: Double
    public var longitude: Double
    public var elevation: Double?
    
    private enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case elevation
    }
    
    public init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: CodingKeys.self) { // 首先尝试创建一个键控容器
            self.latitude = try container.decode(Double.self, forKey: .latitude)
            self.longitude = try container.decode(Double.self, forKey: .longitude)
            self.elevation = try container.decodeIfPresent(Double.self, forKey: .elevation)
        } else if var container = try? decoder.unkeyedContainer() { // 如果不行的话就创建一个非键控容器
            self.longitude = try container.decode(Double.self)
            self.latitude = try container.decode(Double.self)
            self.elevation = try container.decodeIfPresent(Double.self)
        } else if let container = try? decoder.singleValueContainer() { // 如果还不行得话就创建一个单值容器
            let string = try container.decode(String.self)
            
            let scanner = Scanner(string: string)
            scanner.charactersToBeSkipped = CharacterSet(charactersIn: "[ ,]")
            
            var longitude = Double()
            var latitude = Double()
 
            guard scanner.scanDouble(&longitude), scanner.scanDouble(&latitude) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid coordinate string")
            }
            
            self.latitude = latitude
            self.longitude = longitude
            self.elevation = nil
        } else { // 都不行就报错
            let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unable to decode Coordinate")
            throw DecodingError.dataCorrupted(context)
        }
    }
}

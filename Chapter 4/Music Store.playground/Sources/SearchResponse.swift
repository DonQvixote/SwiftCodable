import Foundation

public struct SearchResponse: Decodable {
    public let results: [SearchResult]
}

extension SearchResponse {
    public var nonExplicitResults: [SearchResult] {
        return self.results.filter { result in
            result.trackExplicitness != .explicit
        }
    }
}

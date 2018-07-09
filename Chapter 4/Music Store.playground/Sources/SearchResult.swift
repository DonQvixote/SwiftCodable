import Foundation

// A result returned from the iTunes Search API
public struct SearchResult: Decodable {
    // The name of the track, song, video, TV episode, and so on.
    public let trackName: String?
    
    // The explicitness of the track.
    public let trackExplicitness: Explicitness?
    
    // An iTunes Store URL for the contents.
    public let trackViewURL: URL?
    
    // A URL referencing the 30-seconds preview file for the content associated with the returned media type.
    // - Note: This is available whe media type is track.
    public let previewURL: URL?
    
    // The name of the artist, and so on.
    public let artistName: String?
    
    // The name of the album, TV season, auidobook, and so on.
    public let collectionName: String?
    
    // A URL for the artwork associated with the returned media type.
    private let artworkURL100: URL?
}

extension SearchResult {
    private enum CodingKeys: String, CodingKey {
        case trackName
        case trackExplicitness
        case trackViewURL = "trakcViewUrl"
        case previewURL = "previewUrl"
        case artistName
        case collectionName
        case artworkURL100 = "artworkUrl100"
    }
}

extension SearchResult {
    public func artworkURL(size dimension: Int = 100) -> URL? {
        guard dimension > 0, dimension != 100, var url = self.artworkURL100 else {
            return self.artworkURL100
        }
        
        url.deleteLastPathComponent()
        url.appendPathComponent("\(dimension)x\(dimension)bb.jpg")
        
        return url
    }
}

import Foundation

struct Recipe: Codable, Identifiable {
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let id: String
    let sourceUrl: String?
    let youtubeUrl: String?

    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case id = "uuid"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
}

struct JSONResponse: Codable {
    let recipes: [Recipe]
}

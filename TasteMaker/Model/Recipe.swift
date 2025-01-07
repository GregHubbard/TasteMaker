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
    
    static var example: Recipe {
        Recipe(
            cuisine: "Malaysian",
            name: "Apam Balik",
            photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
            id: "123456789",
            sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    }
}

struct JSONResponse: Codable {
    let recipes: [Recipe]
}

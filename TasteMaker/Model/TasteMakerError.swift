import Foundation

enum TasteMakerError: Error {
    case invalidUrl
    case unableToLoadImageFromData
    
    var description: String {
        switch self {
        case .invalidUrl:
            return "The URL provided is invalid"
        case .unableToLoadImageFromData:
            return "Unable to load image from data"
        }
    }
}

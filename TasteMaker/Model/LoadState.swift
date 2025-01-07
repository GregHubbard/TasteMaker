import Foundation
import SwiftUI

enum LoadState {
    case loading
    case loaded
    case error
}

enum ImageLoadState {
    case loading
    case loaded(UIImage)
    case error
}

import Foundation
import SwiftUI

enum LoadState {
    case error
    case loading
    case loaded
}

enum ImageLoadState {
    case error
    case loading
    case loaded(UIImage)
}

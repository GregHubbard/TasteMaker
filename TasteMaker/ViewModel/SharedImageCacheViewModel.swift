import Foundation
import SwiftUI

@Observable
class SharedImageCacheViewModel {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString (string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject (image, forKey: NSString(string: forKey))
    }
}

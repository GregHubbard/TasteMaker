import Foundation
import SwiftUI

@Observable //TODO: does not need to be observable if not used in environment
class SharedImageCacheViewModel {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString (string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject (image, forKey: NSString(string: forKey))
    }
}

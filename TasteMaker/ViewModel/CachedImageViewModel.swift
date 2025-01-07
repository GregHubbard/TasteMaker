import Foundation
import SwiftUI

@Observable
class CachedImageViewModel {
    var url: URL?
    var sharedImageCache: SharedImageCacheViewModel
    var loadState: ImageLoadState
    
    init(url: URL?, sharedImageCache: SharedImageCacheViewModel) {
        self.url = url
        self.sharedImageCache = sharedImageCache
        self.loadState = .loading
    }
    
    func loadImage() async {
        do {
            guard let url else {
                throw TasteMakerError.invalidUrl
            }
            
            if loadedImageFromCache(for: url) {
                return
            }
            
            try await loadImage(from: url)
        } catch {
            DispatchQueue.main.async {
                self.loadState = .error
            }
            print(error.localizedDescription)
        }
    }
    
    private func loadedImageFromCache(for url: URL) -> Bool {
        guard let cacheImage = sharedImageCache.get(forKey: url.absoluteString) else {
            return false
        }
        
        self.loadState = .loaded(cacheImage)
        return true
    }
    
    private func loadImage(from url: URL) async throws {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let loadedImage = UIImage(data: data) else {
            throw TasteMakerError.unableToLoadImageFromData
        }
        
        DispatchQueue.main.async {
            self.sharedImageCache.set(forKey: url.absoluteString, image: loadedImage)
            self.loadState = .loaded(loadedImage)
        }
    }
}

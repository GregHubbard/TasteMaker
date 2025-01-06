import Foundation
import SwiftUI

@Observable
class CachedImageViewModel {
    var urlString: String
    var sharedImageCache: SharedImageCacheViewModel
    var loadState: ImageLoadState
    
    init(urlString: String, sharedImageCache: SharedImageCacheViewModel) {
        self.urlString = urlString
        self.sharedImageCache = sharedImageCache
        self.loadState = .loading
        loadImage()
    }
    
    func loadImage() {
        if loadedImageFromCache() {
            print("loaded from cache")
            return
        }
        
        Task {
            print("loaded from internet")
            await loadImageFromUrl()
        }
    }
    
    func loadedImageFromCache() -> Bool {
        guard let cacheImage = sharedImageCache.get(forKey: urlString) else {
            return false
        }
        
        self.loadState = .loaded(cacheImage)
        return true
    }
    
    func loadImageFromUrl() async {
        do {
            guard let url = URL(string: urlString) else {
                throw TasteMakerError.invalidUrl
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let loadedImage = UIImage(data: data) else {
                throw TasteMakerError.unableToLoadImageFromData
            }
            
            DispatchQueue.main.async {
                self.sharedImageCache.set(forKey: self.urlString, image: loadedImage)
                self.loadState = .loaded(loadedImage)
            }
        } catch {
            DispatchQueue.main.async {
                self.loadState = .error
            }
            print(error.localizedDescription) //TODO: double check that the this prints the correct error
        }
    }
}
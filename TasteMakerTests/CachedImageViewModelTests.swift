import Foundation
import UIKit
import Testing

@testable import TasteMaker

@MainActor
class CachedImageViewModelTests {
    @Test
    func testLoadImageWithInvalidUrl() async throws {
        let vm = CachedImageViewModel(url: .init(string: ""), sharedImageCache: .init())
        await vm.loadImage()
        #expect(vm.loadState == .error)
    }
    
    @Test
    func testLoadImageFromCache() async throws {
        // add image to cache
        let urlString = "test.com"
        let image = UIImage(systemName: "checkmark")!
        let imageCache = SharedImageCacheViewModel()
        imageCache.set(forKey: urlString, image: image)
        
        let vm = CachedImageViewModel(url: .init(string: urlString), sharedImageCache: imageCache)
        await vm.loadImage()
        #expect(vm.loadState == .loaded(image))
    }
    
    @Test
    func testLoadImageFromUrlUnableToLoadImageFromData() async throws {
        let vm = CachedImageViewModel(url: .init(string: "https://www.apple.com"), sharedImageCache: .init())
        await vm.loadImage()
        #expect(vm.loadState == .error)
    }
    
    @Test
    func testLoadImageFromUrlSaveToCacheAndReloadFromCache() async throws {
        let imageCache = SharedImageCacheViewModel()
        let fileUrl = Bundle(for: type(of: self)).url(forResource: "testImage", withExtension: "jpg")!
        let vm = CachedImageViewModel(url: fileUrl, sharedImageCache: imageCache)
        
        // load image from url
        await vm.loadImage()
        
        // get image saved to cache
        guard let cachedImage = imageCache.get(forKey: fileUrl.absoluteString) else { Issue.record("Image not found in cache")
            return
        }
        
        #expect(vm.loadState == .loaded(cachedImage))
        
        // load image from cache
        await vm.loadImage()
        
        #expect(vm.loadState == .loaded(cachedImage))
    }
}

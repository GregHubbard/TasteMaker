import SwiftUI

struct CachedImageView: View {
    @State var cachedImageViewModel: CachedImageViewModel
    let size: CGFloat = 100
    
    init(urlString: String, imageCache: SharedImageCacheViewModel) {
        cachedImageViewModel = CachedImageViewModel(
            urlString: urlString,
            sharedImageCache: imageCache)
    }
    
    var body: some View {
        Group {
            switch cachedImageViewModel.loadState {
            case .loading:
                ZStack {
                    placeholderView()
                    ProgressView()
                }
            case .loaded(let image):
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            case .error:
                placeholderView()
            }
        }
        .frame(width: size, height: size)
        .clipShape(.rect(cornerRadius: 10))
    }
    
    @ViewBuilder
    func placeholderView() -> some View {
        Rectangle()
            .fill(.gray.gradient)
            .opacity(0.3)
    }
}

#Preview {
    CachedImageView(
        urlString: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
        imageCache: .init())
    
    CachedImageView(
        urlString: "",
        imageCache: .init())
}

import SwiftUI

struct CachedImageView: View {
    @State var vm: CachedImageViewModel
    let size: CGFloat = 100
    
    init(urlString: String, imageCache: SharedImageCacheViewModel) {
        vm = CachedImageViewModel(
            url: .init(string: urlString),
            sharedImageCache: imageCache)
    }
    
    var body: some View {
        Group {
            switch vm.loadState {
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
        .task {
            await vm.loadImage()
        }
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
        urlString: Recipe.example.photoUrlSmall!,
        imageCache: .init())
    
    CachedImageView(
        urlString: "",
        imageCache: .init())
}

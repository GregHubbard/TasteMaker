import SwiftUI

struct RecipeRowView: View {
    @Environment(RecipeViewModel.self) var vm
    @Environment(SharedImageCacheViewModel.self) var imageCache
    
    private let recipe: Recipe
    
    init(_ recipe: Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        if vm.videosShowing {
            DisclosureGroup {
                YoutubeVideoView(urlString: recipe.youtubeUrl)
            } label: {
                recipeRowView()
            }
        } else {
            recipeRowView()
        }
    }
    
    @ViewBuilder
    func recipeRowView() -> some View {
        HStack(spacing: 16) {
            if let photoUrl = recipe.photoUrlSmall {
                CachedImageView(urlString: photoUrl, imageCache: imageCache)
            }
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                    .padding(4)
                    .background(.tertiary, in: .rect(cornerRadius: 5))
                if let sourceUrl = URL(string: recipe.sourceUrl ?? "") {
                    Link("Source", destination: sourceUrl)
                        .font(.caption)
                }
            }
        }
    }
}

#Preview("Normal") {
    List {
        RecipeRowView(Recipe.example)
            .environment(RecipeViewModel.example)
            .environment(SharedImageCacheViewModel())
    }
}

#Preview("Videos Showing") {
    List {
        RecipeRowView(Recipe.example)
            .environment(RecipeViewModel.videosShowing)
            .environment(SharedImageCacheViewModel())
    }
}

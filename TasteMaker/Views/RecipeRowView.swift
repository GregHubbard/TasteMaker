import SwiftUI

struct RecipeRowView: View {
    @Environment(SharedImageCacheViewModel.self) var imageCache
    private let recipe: Recipe
    
    init(_ recipe: Recipe) {
        self.recipe = recipe
    }
    var body: some View {
        HStack {
            if let photoUrl = recipe.photoUrlSmall {
                CachedImageView(urlString: photoUrl, imageCache: imageCache)
            }
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
            }
        }
    }
}

#Preview {
    List {
        RecipeRowView(Recipe.example)
            .environment(SharedImageCacheViewModel())        
    }
}

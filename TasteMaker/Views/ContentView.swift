import SwiftUI

struct ContentView: View {
    @State private var recipes: [Recipe] = []
    @State var imgCache = SharedImageCacheViewModel() //TODO: reevaluate making this in the state 
    
    var body: some View {
        NavigationStack {
            VStack {
                if recipes.isEmpty {
                    Text("Looks like there won't be any cooking today 😔")
                        .padding()
                    Spacer()
                } else {
                    List(recipes) { recipe in
                        HStack {
                            if let photoUrl = recipe.photoUrlSmall {
                                CachedImageView(urlString: photoUrl, imageCache: imgCache)
                            }
                            VStack(alignment: .leading) {
                                Text(recipe.name)
                                    .font(.headline)
                                Text(recipe.cuisine)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .task {
                do {
                    guard let url = URL(string: RecipesUrl.normal) else { return } //TODO: throw and test
                    let (data, _) = try await URLSession.shared.data(from: url)
                    recipes = try JSONDecoder().decode(JSONResponse.self, from: data).recipes //TODO: throw and test
                } catch {
                    print(error) //TODO: handle errors here
                }
            }
            .refreshable {
                //TODO: implement same code from task here
                //possibly force images to reload from internet instead of cache
            }
        }
    }
}

#Preview {
    ContentView()
}

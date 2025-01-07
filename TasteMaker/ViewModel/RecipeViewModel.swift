import Foundation

@Observable
class RecipeViewModel {
    var loadState: LoadState
    var recipes: [Recipe]
    var videosShowing: Bool
    
    init(
        loadState: LoadState = .loading,
        recipes: [Recipe] = [],
        videoShowing: Bool = false) {
        self.loadState = loadState
        self.recipes = recipes
        self.videosShowing = videoShowing
    }
    
    func loadData(url: URL?) async {
        do {
            guard let url else {
                throw TasteMakerError.invalidUrl
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            recipes = try JSONDecoder().decode(JSONResponse.self, from: data).recipes
            loadState = .loaded
        } catch {
            DispatchQueue.main.async {
                self.loadState = .error
            }
            print(error.localizedDescription)
        }
    }
    
    static var example: RecipeViewModel {
        .init(loadState: .loaded, recipes: [Recipe.example])
    }
    
    static var videosShowing: RecipeViewModel {
        .init(loadState: .loaded, recipes: [Recipe.example], videoShowing: true)
    }
    
    static var emptyExample: RecipeViewModel {
        .init(loadState: .loaded, recipes: [])
    }
    
    static var loadingExample: RecipeViewModel {
        .init()
    }
}

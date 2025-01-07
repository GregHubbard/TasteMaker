import Foundation

@Observable
class RecipeViewModel {
    var loadState: LoadState
    var recipes: [Recipe]
    
    init(loadState: LoadState = .loading, recipes: [Recipe] = [])  {
        self.loadState = loadState
        self.recipes = recipes
    }
    
    func loadData(urlString: String) async {
        do {
            guard let url = URL(string: urlString) else {
                throw TasteMakerError.invalidUrl
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            recipes = try JSONDecoder().decode(JSONResponse.self, from: data).recipes
            loadState = .loaded
        } catch {
            DispatchQueue.main.async {
                self.loadState = .error
            }
            print(error.localizedDescription) //TODO: double check that the this prints the correct error
        }
    }
    
    static var example: RecipeViewModel {
        .init(loadState: .loaded, recipes: [Recipe.example])
    }
    
    static var emptyExample: RecipeViewModel {
        .init(loadState: .loaded, recipes: [])
    }
    
    static var loadingExample: RecipeViewModel {
        .init()
    }
}

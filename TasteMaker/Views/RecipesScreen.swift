import SwiftUI

struct RecipesScreen: View {
    @State var vm = RecipeViewModel()
    @State var imageCache = SharedImageCacheViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                switch vm.loadState {
                case .loading:
                    ProgressView()
                        .imageScale(.large)
                case .loaded:
                    RecipeListView()
                case .error:
                    Text("There was an error loading data 🤔")
                        .padding()
                    Spacer()
                }
            }
            .navigationTitle("Recipes")
            .task {
                await vm.loadData(url: URL(string: RecipeUrl.normal))
            }
        }
        .environment(vm)
        .environment(imageCache)
    }
}

#Preview {
    RecipesScreen()
}

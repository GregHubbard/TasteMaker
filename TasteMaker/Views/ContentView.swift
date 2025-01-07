import SwiftUI

struct ContentView: View { //TODO: rename to recipe screen
    @State private var vm = RecipeViewModel()
    @State var imageCache = SharedImageCacheViewModel() //TODO: reevaluate making this in the state
    
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
                await vm.loadData(urlString: RecipeUrl.normal)
            }
        }
        .environment(vm)
        .environment(imageCache)
    }
}

#Preview {
    ContentView()
}

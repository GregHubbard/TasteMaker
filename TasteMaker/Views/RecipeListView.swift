import SwiftUI

struct RecipeListView: View {
    @Environment(RecipeViewModel.self) var vm
    
    var body: some View {
        if vm.recipes.isEmpty {
            Text("Looks like there won't be any cooking today 😔")
                .padding()
            Spacer()
        } else {
            List(vm.recipes) { recipe in
                RecipeRowView(recipe)
            }
            .refreshable {
                await vm.loadData(urlString: RecipeUrl.normal)
                //TODO: possibly force images to reload from internet instead of cache
            }
        }
    }
}

#Preview {
    RecipeListView()
        .environment(RecipeViewModel.example)
        .environment(SharedImageCacheViewModel())
}

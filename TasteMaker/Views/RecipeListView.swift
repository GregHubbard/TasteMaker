import SwiftUI

struct RecipeListView: View {
    @Environment(RecipeViewModel.self) var vm
    
    var body: some View {
        if vm.recipes.isEmpty {
            Text("No recipes available, looks like there won't be any cooking today 😔")
                .padding()
            Spacer()
        } else {
            List(vm.recipes) { recipe in
                RecipeRowView(recipe)
            }
            .refreshable {
                await vm.loadData(urlString: RecipeUrl.normal)
            }
        }
    }
}

#Preview("Normal") {
    RecipeListView()
        .environment(RecipeViewModel.example)
        .environment(SharedImageCacheViewModel())
}

#Preview("Empty") {
    RecipeListView()
        .environment(RecipeViewModel.emptyExample)
        .environment(SharedImageCacheViewModel())
}

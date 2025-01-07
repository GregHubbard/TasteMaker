import SwiftUI

struct RecipeListView: View {
    @Environment(RecipeViewModel.self) var vm
    
    var body: some View {
        if vm.recipes.isEmpty {
            Text("No recipes available, looks like there won't be any cooking today 😔")
                .padding()
            Spacer()
        } else {
            @Bindable var vm = vm
            List(vm.recipes) { recipe in
                    RecipeRowView(recipe)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Toggle("", systemImage: "play.rectangle.fill", isOn: $vm.videosShowing)
                }
            }
            .refreshable {
                await vm.loadData(url: URL(string: RecipeUrl.normal))
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

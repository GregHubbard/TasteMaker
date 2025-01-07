import Foundation
import Testing

@testable import TasteMaker

@MainActor
class RecipeViewModelTests {
    @Test
    func testLoadDataErrorStateWithInvalidUrl() async throws {
        let vm = RecipeViewModel()
        await vm.loadData(url: URL(string: ""))
        #expect(vm.loadState == .error)
        #expect(vm.recipes.count == 0)
    }
    
    @Test
    func testLoadDataNormal() async throws {
        let vm = RecipeViewModel()
        let fileUrl = Bundle(for: RecipeViewModelTests.self).url(forResource: "recipeJsonNormal", withExtension: "json")
        await vm.loadData(url: fileUrl)
        
        #expect(vm.loadState == .loaded)
        #expect(vm.recipes.count == 1)
    }
    
    @Test
    func testLoadDataMalformed() async throws {
        let vm = RecipeViewModel()
        let fileUrl = Bundle(for: RecipeViewModelTests.self).url(forResource: "recipeJsonMalformed", withExtension: "json")
        await vm.loadData(url: fileUrl)
        
        #expect(vm.loadState == .error)
        #expect(vm.recipes.count == 0)
    }
}

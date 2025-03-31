//
//  RecipesListViewModel.swift
//  FetchTakeHome
//
//  Created by Oren Leavitt on 3/22/25.
//

import Foundation

@MainActor
class RecipesListViewModel: ObservableObject {
    @Published var state: RecipedListState = .empty

    var fetchRecipesEndpoint: Endpoint = .recipes

    /// Get the underlying array of recipes contained within the Recipes response object - if we have it
    var recipes: [Recipe] {
        recipesObject?.recipes ?? []
    }

    private let networkLayer: NetworkLayer
    private var recipesObject: Recipes?
    private var error: Error?
    private var errorMessageInternal = ""

    init(networkLayer: NetworkLayer) {
        self.networkLayer = networkLayer
    }

    func fetchRecipes() async {
        guard let url = URL(string: fetchRecipesEndpoint.urlString) else {
            error = URLError(.badURL)
            state = .error
            return
        }

        state = .loading

        let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)

        do {
            let recipes = try await networkLayer.fetchJsonData(request: urlRequest, type: Recipes.self)
            recipesObject = recipes
            state = recipes.recipes.isEmpty ? .empty : .success
        } catch let decodingError as DecodingError {
            errorMessageInternal = String(localized: "recipes-could-not-be-decoded")
            self.error = decodingError
            state = .error
        } catch {
            self.error = error
            state = .error
        }
    }

    var errorMessage: String {
        if errorMessageInternal.isEmpty {
            return error?.localizedDescription ?? ""
        }
        return errorMessageInternal
    }
}

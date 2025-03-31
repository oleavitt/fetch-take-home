//
//  RecipesListViewModelTests.swift
//  FetchTakeHomeTests
//
//  Created by Oren Leavitt on 3/22/25.
//

import XCTest
@testable import FetchTakeHome

@MainActor
final class RecipesListViewModelTests: XCTestCase {

    private let networkLayer = NetworkLayerMock()
    private var viewModel = RecipesListViewModel(networkLayer: NetworkLayerMock())

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = RecipesListViewModel(networkLayer: networkLayer)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        NetworkLayerMock.simulateNetworkError = false
    }

    func testEmptyViewModel() async throws {
        XCTAssertEqual(viewModel.state, .empty)
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertTrue(viewModel.errorMessage.isEmpty)
    }

    func testFetchRecipes() async throws {
        await viewModel.fetchRecipes()
        XCTAssertEqual(viewModel.state, .success)
        XCTAssertEqual(viewModel.recipes.count, 3)
        XCTAssertTrue(viewModel.errorMessage.isEmpty)
    }

    func testFetchRecipesMalformed() async throws {
        viewModel.fetchRecipesEndpoint = .malformed
        await viewModel.fetchRecipes()
        XCTAssertEqual(viewModel.state, .error)
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertFalse(viewModel.errorMessage.isEmpty)
    }

    func testFetchRecipesEmpty() async throws {
        viewModel.fetchRecipesEndpoint = .empty
        await viewModel.fetchRecipes()
        XCTAssertEqual(viewModel.state, .empty)
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertTrue(viewModel.errorMessage.isEmpty)
    }

    func testFetchRecipesNetworkError() async throws {
        NetworkLayerMock.simulateNetworkError = true
        await viewModel.fetchRecipes()
        XCTAssertEqual(viewModel.state, .error)
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertFalse(viewModel.errorMessage.isEmpty)
    }
}

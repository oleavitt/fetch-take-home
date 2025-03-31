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

    private var viewModel = RecipesListViewModel(networkLayer: NetworkLayerMock())

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = RecipesListViewModel(networkLayer: NetworkLayerMock())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmptyViewModel() async throws {
    }
}

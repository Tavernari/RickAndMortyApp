//
//  CharacterListViewControllerTests.swift
//  
//
//  Created by Victor C Tavernari on 20/01/21.
//

import XCTest
import Combine
import Shared
import SnapshotTesting
import UIKit
@testable import CharacterList

final class CharacterListViewControllerTests: XCTestCase {

    lazy var repository = CharactersRepositoryMock()
    lazy var favoriteAdapter = FavoriteCharactersAdapterMock()
    lazy var fetchCharacterUseCase = FetchCharactersUseCase(repository: repository)
    lazy var viewModel = CharacterListViewModelMock(fetchCaractersUseCase: fetchCharacterUseCase,
                                                favoriteCharactersAdapter: favoriteAdapter)
    lazy var viewController = CharacterListViewController()

    override func setUp() {
        super.setUp()
        viewController.viewModel = viewModel
    }

    private func lifeCycle() {
        viewController.viewDidLoad()
        viewController.viewWillAppear(true)
        viewController.viewDidAppear(true)
    }

    func testCharactersAllUnfavorite_onIPhoneX() {
        viewModel.favoritedMock = false
        viewModel.allCharacters = [
            .init(name: "Test", imagePath: ""),
            .init(name: "Test 2", imagePath: "")]
        viewModel.characters = [.mock(id: 1), .mock(id: 2)]
        viewModel.segment = .allCharacters

        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }

    func testCharactersAllFavorited_onIPhoneX() {
        viewModel.favoritedMock = true
        viewModel.allCharacters = [
            .init(name: "Test", imagePath: ""),
            .init(name: "Test 2", imagePath: ""),
            .init(name: "Test 3", imagePath: "")]
        viewModel.characters = [.mock(id: 1),
                                .mock(id: 2),
                                .mock(id: 3)]
        viewModel.segment = .allCharacters
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }

    func testSegmentFavoritesCharacters_onIPhoneX() {
        viewModel.favoritedMock = true
        viewModel.allFavorites = [
            .init(name: "Favorite Test", imagePath: ""),
            .init(name: "Favorite Test 2", imagePath: ""),
            .init(name: "Favorite Test 3", imagePath: "")]
        viewModel.favorites = [.mock(id: 1),
                                .mock(id: 2),
                                .mock(id: 3)]
        viewController.segmentControl.selectedSegmentIndex = 1
        viewController.segmentChanged()

        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }
}

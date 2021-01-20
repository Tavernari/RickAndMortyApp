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
    }

    private func lifeCycle() {
        viewController.viewModel = viewModel
        viewController.view.frame = UIScreen.main.bounds

        viewController.viewDidLoad()
        viewController.viewWillAppear(true)
        viewController.viewDidAppear(true)
    }

    func testCharactersAllUnfavorite_onIPhoneX() {
        viewModel.favoritedMock = false
        viewModel.items = [
            .init(name: "Test", imagePath: ""),
            .init(name: "Test 2", imagePath: "")]
        viewModel.characters = [.mock(id: 1), .mock(id: 2)]

        lifeCycle()
        
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }

    func testCharactersAllFavorited_onIPhoneX() {
        viewModel.favoritedMock = true
        viewModel.items = [
            .init(name: "Test", imagePath: ""),
            .init(name: "Test 2", imagePath: ""),
            .init(name: "Test 3", imagePath: "")]
        viewModel.characters = [.mock(id: 1),
                                .mock(id: 2),
                                .mock(id: 3)]

        lifeCycle()

        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }
}

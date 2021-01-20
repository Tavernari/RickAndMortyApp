//
//  CharacterDetailsViewModelTests.swift
//  
//
//  Created by Victor C Tavernari on 20/01/21.
//

import Foundation
import XCTest
import Shared
@testable import CharacterDetails

final class CharacterDetailsViewModelTests: XCTestCase {

    lazy var favoriteAdapter = FavoriteCharactersAdapterMock()
    lazy var character = Character(id: 1,
                                   name: "Rick Morty",
                                   avatar: "",
                                   status: .unknown,
                                   species: "species",
                                   type: "type",
                                   gender: .notDefined,
                                   origin: "origin",
                                   location: "location",
                                   episode: [])

    lazy var viewModel = CharacterDetailsViewModel(character: character,
                                                   favoriteCharacterAdapter: favoriteAdapter)

    lazy var viewController = CharacterDetailsViewController()

    fileprivate func assertStructure(isFavorited: Bool) {
        XCTAssertEqual(viewModel.items[0],
                       CharacterDetailsViewModel.ViewData.header(name: "Rick Morty",
                                                                 avatar: "",
                                                                 isFavorite: isFavorited))
        XCTAssertEqual(viewModel.items[1],
                       CharacterDetailsViewModel.ViewData.title(title: "Location"))
        XCTAssertEqual(viewModel.items[2],
                       CharacterDetailsViewModel.ViewData.location(origin: "Origin",
                                                                   location: "Location"))
        XCTAssertEqual(viewModel.items[3],
                       CharacterDetailsViewModel.ViewData.title(title: "Infos"))
        XCTAssertEqual(viewModel.items[4],
                       CharacterDetailsViewModel.ViewData.info(title: "Gender",
                                                               value: "Undefined"))
        XCTAssertEqual(viewModel.items[5],
                       CharacterDetailsViewModel.ViewData.info(title: "Species",
                                                               value: "species"))
        XCTAssertEqual(viewModel.items[6],
                       CharacterDetailsViewModel.ViewData.info(title: "Type",
                                                               value: "type"))
        XCTAssertEqual(viewModel.items[7],
                       CharacterDetailsViewModel.ViewData.info(title: "Is it alive?",
                                                               value: "Who's know?"))
        XCTAssertEqual(viewModel.items[8],
                       CharacterDetailsViewModel.ViewData.episodes(episodes: []))
    }

    func testViewModelViewData() {
        assertStructure(isFavorited: false)
    }

    func testFavorite() {
        viewModel.favorite()
        XCTAssertEqual(favoriteAdapter.addToFavoritesCallCount, 1)
    }

    func testUnfavorite() {
        viewModel.unfavorite()
        XCTAssertEqual(favoriteAdapter.removeFromFavoritesCallCount, 1)
    }

    func testWasFavorited() {
        _ = viewModel.wasFavorited()
        XCTAssertEqual(favoriteAdapter.wasFavoritedCallCount, 1)
    }
}

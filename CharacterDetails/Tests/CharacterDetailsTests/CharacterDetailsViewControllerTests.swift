//
//  CharacterDetailsViewControllerTests.swift
//  
//
//  Created by Victor C Tavernari on 20/01/21.
//

import XCTest
import Combine
import Shared
import SnapshotTesting
import UIKit
@testable import CharacterDetails

final class CharacterDetailsViewControllerTests: XCTestCase {

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

    func testCharactersDetail_onIPhoneX() {
        favoriteAdapter.favoritedMock = false
        lifeCycle()

        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }

    func testCharactersDetailFavorited_onIPhoneX() {
        favoriteAdapter.favoritedMock = true
        lifeCycle()

        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
    }
}


//
//  AddToFavoriteUseCaseTests.swift
//  
//
//  Created by Victor C Tavernari on 19/01/21.
//

import Foundation
import Shared
import Combine
import XCTest
@testable import FavoriteCharacters

final class AddToFavoriteUseCaseTests: XCTestCase {

    lazy var character1 = Character(id: 1, name: "Rick", avatar: "")
    lazy var character2 = Character(id: 2, name: "Morty", avatar: "")
    lazy var addToFavoriteUseCase = AddToFavoriteUseCase()
    lazy var removeFromFavoriteUseCase = RemoveFromFavoriteUseCase()
    lazy var checkIfCharacterWasFavoritedUseCase = CheckIfCharacterWasFavoritedUseCase()

    override func tearDown() {
        super.tearDown()
        UserDefaults.standard.removeObject(forKey: LocalFavoritesCharactersRepository.storageKey)
    }

    func testAddCharacterToFavorite() {
        let expectation = XCTestExpectation(description: "Waiting to check if added to favorite")

        _ = addToFavoriteUseCase.run(character: character1)

        _ = checkIfCharacterWasFavoritedUseCase.run(character: character1).sink(receiveCompletion: { _ in
        }, receiveValue: { exist in
            XCTAssert(exist)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 2)
    }

    func testRemoveCharacterFromFavorite() {
        let expectationForCharacter1 = XCTestExpectation(description: "Waiting to check character1")
        let expectationForCharacter2 = XCTestExpectation(description: "Waiting to check character2")

        _ = addToFavoriteUseCase.run(character: character1)
        _ = addToFavoriteUseCase.run(character: character2)
        _ = removeFromFavoriteUseCase.run(character: character1)

        _ = checkIfCharacterWasFavoritedUseCase.run(character: character1).sink { _ in
        } receiveValue: { exist in
            XCTAssertFalse(exist)
            expectationForCharacter1.fulfill()
        }
        _ = checkIfCharacterWasFavoritedUseCase.run(character: character2).sink { _ in
        } receiveValue: { exist in
            XCTAssert(exist)
            expectationForCharacter2.fulfill()
        }


        wait(for: [expectationForCharacter1, expectationForCharacter2], timeout: 2)
    }
}

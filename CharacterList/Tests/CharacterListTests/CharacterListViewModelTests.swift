//
//  CharacterListViewModelTests.swift
//  
//
//  Created by Victor C Tavernari on 19/01/21.
//

import XCTest
import Combine
import Shared
@testable import CharacterList

final class CharacterListViewModelTests: XCTestCase {

    lazy var repository = CharactersRepositoryMock()
    lazy var favoriteAdapter = FavoriteCharactersAdapterMock()
    lazy var fetchCharacterUseCase = FetchCharactersUseCase(repository: repository)
    lazy var viewModel = CharacterListViewModel(fetchCaractersUseCase: fetchCharacterUseCase,
                                                favoriteCharactersAdapter: favoriteAdapter)

    func testFetchCharacters() {
        let loadingExpectation = XCTestExpectation(description: "Waiting for state loading")
        let doneExpectation = XCTestExpectation(description: "Waiting for state done")
        repository.mockFetch(characters: [.mock(id: 1),
                                          .mock(id: 2),
                                          .mock(id: 3)])

        viewModel.onUpdated = { [self] state in
            switch state {
            case .loading:
                loadingExpectation.fulfill()
            case .itemsUpdated:
                doneExpectation.fulfill()
                XCTAssertEqual(viewModel.items.count, 3)
            default:
                XCTFail()
            }
        }

        viewModel.fetchCharacters()

        wait(for: [loadingExpectation, doneExpectation], timeout: 1)
    }

    func testFetchCharactersWithSomeError() {
        let loadingExpectation = XCTestExpectation(description: "Waiting for state loading")
        let failedExpectation = XCTestExpectation(description: "Waiting for state failed")
        repository.mockError(error: .somethingWrong)

        viewModel.onUpdated = { state in
            switch state {
            case .loading:
                loadingExpectation.fulfill()
            case .failed:
                failedExpectation.fulfill()
            default:
                XCTFail()
            }
        }

        viewModel.fetchCharacters()

        wait(for: [loadingExpectation, failedExpectation], timeout: 1)
    }

    func testFetchCharactersWhenFinishedPagination() {
        let loadingExpectation = XCTestExpectation(description: "Waiting for state loading")
        let doneExpectation = XCTestExpectation(description: "Waiting for state failed")
        repository.mockError(error: .nothingToShow)

        viewModel.onUpdated = { state in
            switch state {
            case .loading:
                loadingExpectation.fulfill()
            case .itemsUpdated:
                doneExpectation.fulfill()
            default:
                XCTFail()
            }
        }

        viewModel.fetchCharacters()

        wait(for: [loadingExpectation, doneExpectation], timeout: 1)
    }

    func testSelectCharacter() {
        let loadingExpectation = XCTestExpectation(description: "Waiting for state loading")
        let doneExpectation = XCTestExpectation(description: "Waiting for state done")
        let selectedExpectation = XCTestExpectation(description: "Waiting for state selected")
        repository.mockFetch(characters: [.mock(id: 1),
                                          .mock(id: 2)])

        viewModel.onUpdated = { [self] state in
            switch state {
            case .loading:
                loadingExpectation.fulfill()
            case .itemsUpdated:
                doneExpectation.fulfill()
                XCTAssertEqual(viewModel.items.count, 2)

                viewModel.select(index: 0)
            case .selected(let character):
                selectedExpectation.fulfill()
                XCTAssertEqual(character.id, 1)
            default:
                XCTFail()
            }
        }

        viewModel.fetchCharacters()


        wait(for: [loadingExpectation, doneExpectation, selectedExpectation], timeout: 1)
    }

    func testFavoriteFlowCharacters() {
        let expectation = XCTestExpectation(description: "Waiting favorite flow")

        repository.mockFetch(characters: [.mock(id: 1),
                                          .mock(id: 2)])

        viewModel.onUpdated = { [self] state in
            switch state {
            case .loading: break
            case .itemsUpdated:
                viewModel.favorite(index: 0)
                viewModel.favorite(index: 1)
                viewModel.unfavorite(index: 0)
                _ = viewModel.wasFavorited(index: 0)
                expectation.fulfill()
                XCTAssertEqual(favoriteAdapter.addToFavoritesCallCount, 2)
                XCTAssertEqual(favoriteAdapter.removeFromFavoritesCallCount, 1)
                XCTAssertEqual(favoriteAdapter.wasFavoritedCallCount, 1)
            default:
                XCTFail()
            }
        }

        viewModel.fetchCharacters()

        wait(for: [expectation], timeout: 1)
    }


}

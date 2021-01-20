//
//  CharacterListViewModelSpy.swift
//  
//
//  Created by Victor C Tavernari on 20/01/21.
//

import Foundation
import Combine
import Shared
@testable import CharacterList

class CharacterListViewModelMock: CharacterListViewModel {
    var fetchCharactersCallCount = 0
    var selectCallCount = 0
    var favoriteCallCount = 0
    var unfavoriteCallCount = 0
    var wasFavoritedCallCount = 0
    var fetchFavoritesCallCount = 0
    var favoritedMock = false

    override func fetchCharacters() {
        fetchCharactersCallCount += 1
        self.onUpdated?(.itemsUpdated)
    }

    override func fetchFavorites() {
        fetchFavoritesCallCount += 1
        self.onUpdated?(.itemsUpdated)
    }

    override func unfavorite(index: Int) {
        unfavoriteCallCount += 1
    }

    override func favorite(index: Int) {
        favoriteCallCount += 1
    }

    override func wasFavorited(index: Int) -> Future<Bool, Error> {
        wasFavoritedCallCount += 1
        return .init { promise in
            promise(.success(self.favoritedMock))
        }
    }

    override func select(index: Int) {
        selectCallCount = 0
        super.select(index: index)
    }
}

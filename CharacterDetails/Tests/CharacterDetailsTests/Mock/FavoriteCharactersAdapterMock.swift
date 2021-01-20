//
//  FavoriteCharactersAdapterMock.swift
//  
//
//  Created by Victor C Tavernari on 20/01/21.
//

import Foundation
import Shared
import Combine

class FavoriteCharactersAdapterMock: Shared.FavoriteCharactersAdapter {
    var addToFavoritesCallCount = 0
    var removeFromFavoritesCallCount = 0
    var wasFavoritedCallCount = 0
    var allFavoritesCount = 0
    var favoritedMock = false
    func addToFavorites(character: Character) -> Future<Void, Error> {
        addToFavoritesCallCount += 1
        return .init { promise in
            promise(.success(()))
        }
    }

    func removeFromFavorites(character: Character) -> Future<Void, Error> {
        removeFromFavoritesCallCount += 1
        return .init { promise in
            promise(.success(()))
        }
    }

    func wasFavorited(character: Character) -> Future<Bool, Error> {
        wasFavoritedCallCount += 1
        return .init { promise in
            promise(.success(self.favoritedMock))
        }
    }

    func allFavorites() -> Future<[Character], Error> {
        allFavoritesCount += 1
        return .init { promise in
            promise(.success([]))
        }
    }
}

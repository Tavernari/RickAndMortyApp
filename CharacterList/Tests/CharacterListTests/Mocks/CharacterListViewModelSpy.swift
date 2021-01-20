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

class CharacterListViewModelSpy: CharacterListViewModel {
    var fetchCharactersCallCount = 0
    var selectCallCount = 0
    var favoriteCallCount = 0
    var unfavoriteCallCount = 0
    var wasFavoritedCallCount = 0

    override func fetchCharacters() {
        fetchCharactersCallCount += 1
        super.fetchCharacters()
    }

    override func unfavorite(index: Int) {
        unfavoriteCallCount += 1
        super.unfavorite(index: index)
    }

    override func favorite(index: Int) {
        favoriteCallCount += 1
        super.favorite(index: index)
    }

    override func wasFavorited(index: Int) -> Future<Bool, Error> {
        wasFavoritedCallCount += 1
        return super.wasFavorited(index: index)
    }

    override func select(index: Int) {
        selectCallCount = 0
        super.select(index: index)
    }
}

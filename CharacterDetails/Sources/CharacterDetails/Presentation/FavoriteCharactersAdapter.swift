//
//  FavoriteCharactersAdapter.swift
//  
//
//  Created by Victor C Tavernari on 19/01/21.
//

import Shared
import FavoriteCharacters
import Combine

class FavoriteCharactersAdapter: Shared.FavoriteCharactersAdapter {
    let addToFavoriteUseCase = AddToFavoriteUseCase()
    let removeFromFavoriteUseCase = RemoveFromFavoriteUseCase()
    let checkIfCharacterWasFavoritedUseCase = CheckIfCharacterWasFavoritedUseCase()

    func addToFavorites(character: Character) -> Future<Void, Error> {
        return addToFavoriteUseCase.run(character: character)
    }

    func removeFromFavorites(character: Character) -> Future<Void, Error>{
        return removeFromFavoriteUseCase.run(character: character)
    }

    func wasFavorited(character: Character) -> Future<Bool, Error> {
        return checkIfCharacterWasFavoritedUseCase.run(character: character)
    }
}

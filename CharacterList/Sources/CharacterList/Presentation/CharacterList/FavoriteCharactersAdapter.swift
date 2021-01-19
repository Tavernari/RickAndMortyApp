//
//  File.swift
//  
//
//  Created by Victor C Tavernari on 19/01/21.
//

import Shared
import FavoriteCharacters
import Combine

public class FavoriteCharactersAdapter: Shared.FavoriteCharactersAdapter {
    let addToFavoriteUseCase = AddToFavoriteUseCase()
    let removeFromFavoriteUseCase = RemoveFromFavoriteUseCase()
    let checkIfCharacterWasFavoritedUseCase = CheckIfCharacterWasFavoritedUseCase()

    public func addToFavorites(character: Character) -> Future<Void, Error> {
        return addToFavoriteUseCase.run(character: character)
    }

    public func removeFromFavorites(character: Character) -> Future<Void, Error>{
        return removeFromFavoriteUseCase.run(character: character)
    }

    public func wasFavorited(character: Character) -> Future<Bool, Error> {
        return checkIfCharacterWasFavoritedUseCase.run(character: character)
    }
}

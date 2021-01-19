//
//  AddToFavoriteUseCase.swift
//  
//
//  Created by Victor C Tavernari on 19/01/21.
//

import Foundation
import Combine
import Shared

public class AddToFavoriteUseCase {
    var respository: FavoritesCharactersRepository = LocalFavoritesCharactersRepository()
    func run(character: Character) -> Future<Void, Error> {
        return self.respository.save(character: character)
    }
}

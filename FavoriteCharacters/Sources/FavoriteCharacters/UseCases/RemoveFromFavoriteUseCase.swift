//
//  RemoveFromFavoriteUseCase.swift
//  
//
//  Created by Victor C Tavernari on 19/01/21.
//

import Foundation
import Combine
import Shared

public class RemoveFromFavoriteUseCase {
    var respository: FavoritesCharactersRepository = LocalFavoritesCharactersRepository()
    
    public init() {}

    public func run(character: Character) -> Future<Void, Error> {
        return self.respository.remove(character: character)
    }
}

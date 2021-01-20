//
//  FavoriteCharactersAdapter.swift
//  
//
//  Created by Victor C Tavernari on 19/01/21.
//

import Foundation
import Combine

public protocol FavoriteCharactersAdapter {
    func addToFavorites(character: Character) -> Future<Void, Error>
    func removeFromFavorites(character: Character)  -> Future<Void, Error>
    func wasFavorited(character: Character) -> Future<Bool, Error>
    func allFavorites() -> Future<[Character], Error>
}

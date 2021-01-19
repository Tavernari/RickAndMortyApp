//
//  FavoritesCharactersRepository.swift
//  
//
//  Created by Victor C Tavernari on 19/01/21.
//

import Foundation
import Shared
import Combine

public protocol FavoritesCharactersRepository {
    func save(character: Character) -> Future<Void, Error>
    func remove(character: Character) -> Future<Void, Error>
    func get() -> Future<[Character], Error>
}

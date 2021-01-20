//
//  CharacterDetailsViewModel.swift
//  
//
//  Created by Victor C Tavernari on 18/01/21.
//

import Foundation
import Shared
import Combine

class CharacterDetailsViewModel {
    enum ViewData: Equatable {
        case header(name: String, avatar: String, isFavorite: Bool)
        case title(title: String)
        case info(title: String, value: String)
        case location(origin: String, location: String)
        case episodes(episodes: [String])
    }

    var items: [ViewData] = []

    let name: String
    private let character: Character
    private let favoriteCharacter: Shared.FavoriteCharactersAdapter
    init(character: Character, favoriteCharacterAdapter: Shared.FavoriteCharactersAdapter) {

        self.favoriteCharacter = favoriteCharacterAdapter
        self.character = character

        self.name = character.name

        let status: String
        switch character.status {
        case .alive:
            status = "It's alive"
        case .dead:
            status = "It's dead"
        default:
            status = "Who's know?"
        }

        let gender: String
        switch character.gender {
        case .female:
            gender = "Female"
        case .male:
            gender = "Male"
        default:
            gender = "Not defined"
        }

        items.append(.header(name: character.name,
                             avatar: character.avatar,
                             isFavorite: false))
        items.append(.title(title: "Location"))
        items.append(.location(origin: character.origin.capitalized, location: character.location.capitalized))
        items.append(.title(title: "Infos"))
        items.append(.info(title: "Gender", value: gender))
        items.append(.info(title: "Species", value: character.species))
        if !character.type.isEmpty {
            items.append(.info(title: "Type", value: character.type))
        }
        items.append(.info(title: "Is it alive?", value: status))
        items.append(.episodes(episodes: character.episode))
    }

    func favorite() {
        _ = favoriteCharacter.addToFavorites(character: character)
    }

    func unfavorite()  {
        _ = favoriteCharacter.removeFromFavorites(character: character)
    }

    func wasFavorited() -> Future<Bool, Error> {
        return favoriteCharacter.wasFavorited(character: character)
    }
}

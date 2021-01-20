//
//  CharacterListViewModel.swift
//  
//
//  Created by Victor C Tavernari on 14/01/21.
//

import UIKit
import Combine
import Shared

class CharacterListViewModel {

    enum State {
        case loading
        case itemsUpdated
        case failed
        case selected(character: Character)
    }

    enum Segment: Int {
        case allCharacters = 0
        case allFavorites = 1
    }

    struct ViewData {
        let name: String
        let imagePath: String
    }

    private var allFavorites: [ViewData] = []
    private var allCharacters: [ViewData] = []
    var segment: Segment = .allCharacters {
        didSet {
            switch segment {
            case .allCharacters:
                items = allCharacters
            case .allFavorites:
                items = allFavorites
            }

            onUpdated?(.itemsUpdated)
        }
    }
    var items: [ViewData] = []
    var characters: [Character] = []
    var favorites: [Character] = []

    var onUpdated: ((State)->Void)?

    private var isAllCharactersLoaded = false
    private var fetchCharactersCancelable: AnyCancellable?
    private var favorited = Set<Int>()

    private let fetchCaractersUseCase: FetchCharactersUseCase
    private let favoriteCharacter: Shared.FavoriteCharactersAdapter
    init(fetchCaractersUseCase: FetchCharactersUseCase, favoriteCharactersAdapter: Shared.FavoriteCharactersAdapter) {
        self.fetchCaractersUseCase = fetchCaractersUseCase
        self.favoriteCharacter = favoriteCharactersAdapter

        fetchFavorites()
    }

    func fetchCharacters() {
        guard !isAllCharactersLoaded && fetchCharactersCancelable == nil else { return }
        onUpdated?(.loading)
        fetchCharactersCancelable = fetchCaractersUseCase.run()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.fetchCharactersCancelable = nil
                switch completion {
                case .failure(let error):
                    guard error == .somethingWrong else {
                        self.isAllCharactersLoaded = true
                        self.onUpdated?(.itemsUpdated)
                        return
                    }

                    self.onUpdated?(.failed)
                default: break
                }
        } receiveValue: { characters in
            self.characters.append(contentsOf: characters)
            self.allCharacters.append(contentsOf: characters.map { ViewData(name: $0.name, imagePath: $0.avatar) })
            self.updateItems()
        }
    }

    private func updateItems() {
        switch segment {
        case .allCharacters:
            items = allCharacters
        case .allFavorites:
            items = allFavorites
        }

        self.onUpdated?(.itemsUpdated)
    }

    func fetchFavorites() {
        _ = favoriteCharacter.allFavorites().sink { completion in
            switch completion {
            case .failure:
                self.allFavorites = []
            default: break
            }
        } receiveValue: { favorites in
            self.favorites = favorites
            self.allFavorites = favorites.map { ViewData(name: $0.name, imagePath: $0.avatar) }
        }
    }

    func favorite(index: Int) {
        let character = segment == .allCharacters ? characters[index] : favorites[index]
        _ = favoriteCharacter
            .addToFavorites(character: character)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in
                self.fetchFavorites()
            })
    }

    func unfavorite(index: Int)  {
        let character = segment == .allCharacters ? characters[index] : favorites[index]
        _ = favoriteCharacter
            .removeFromFavorites(character: character)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in
                self.fetchFavorites()
            })
    }

    func wasFavorited(index: Int) -> Future<Bool, Error> {
        let character = segment == .allCharacters ? characters[index] : favorites[index]
        return favoriteCharacter.wasFavorited(character: character)
    }

    func select(index: Int) {
        let character = segment == .allCharacters ? characters[index] : favorites[index]
        onUpdated?(.selected(character: character))
    }
}

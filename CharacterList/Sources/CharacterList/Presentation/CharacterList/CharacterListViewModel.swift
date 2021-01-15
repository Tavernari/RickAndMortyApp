//
//  CharacterListViewModel.swift
//  
//
//  Created by Victor C Tavernari on 14/01/21.
//

import UIKit

class CharacterListViewModel {

    enum State {
        case loading
        case done
        case failed(errorMessage: String)
    }

    struct ViewData {
        let name: String
        let imagePath: String
    }

    var items: [ViewData] = []
    private var characters: [Character] = []

    var onUpdated: ((State)->Void)?

    private var favorited = Set<Int>()

    private let fetchCaractersUseCase: FetchCharactersUseCase
    init(fetchCaractersUseCase: FetchCharactersUseCase) {
        self.fetchCaractersUseCase = fetchCaractersUseCase
    }

    func fetchCharacters() {
        onUpdated?(.loading)
        fetchCaractersUseCase.run().sink { error in
        } receiveValue: { characters in
            self.characters.append(contentsOf: characters)
            self.items.append(contentsOf: characters.map { ViewData(name: $0.name, imagePath: $0.avatar) })
            self.onUpdated?(.done)
        }

    }

    func favorite(index: Int) {
        let id = characters[index].id
        favorited.insert(id)
    }

    func unfavorite(index: Int) {
        let id = characters[index].id
        favorited.remove(id)
    }

    func wasFavorited(index: Int) -> Bool {
        let id = characters[index].id
        return favorited.contains(id)
    }
}

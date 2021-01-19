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
        case done
        case failed
        case selected(character: Character)
    }

    struct ViewData {
        let name: String
        let imagePath: String
    }

    var items: [ViewData] = []
    private var characters: [Character] = []

    var onUpdated: ((State)->Void)?

    private var isAllCharactersLoaded = false
    private var fetchCharactersCancelable: AnyCancellable?
    private var favorited = Set<Int>()

    private let fetchCaractersUseCase: FetchCharactersUseCase
    init(fetchCaractersUseCase: FetchCharactersUseCase) {
        self.fetchCaractersUseCase = fetchCaractersUseCase
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
                        self.onUpdated?(.done)
                        return
                    }

                    self.onUpdated?(.failed)
                default: break
                }
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

    func select(index: Int) {
        let character = characters[index]
        onUpdated?(.selected(character: character))
    }
}

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
        let id: Int
        let name: String
        let imagePath: String
    }

    var items: [ViewData] = []

    var onUpdated: ((State)->Void)?

    init() {

    }

    func fetchCharacters() {
        onUpdated?(.loading)
        items.append(.init(id: 1,
                           name: "Bobby Moynihan",
                           imagePath: "https://rickandmortyapi.com/api/character/avatar/54.jpeg"))
        onUpdated?(.done)
    }
}

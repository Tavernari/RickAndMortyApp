//
//  CharacterDetailsViewModel.swift
//  
//
//  Created by Victor C Tavernari on 18/01/21.
//

import Foundation

class CharacterDetailsViewModel {
    enum ViewData {
        case header(name: String, avatar: String, isFavorite: Bool)
        case info(title: String, value: String)
        case episodes(episodes: [String])
    }

    var items: [ViewData] = [
        .header(name: "Rick Sanchez", avatar: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", isFavorite: true)
    ]
}

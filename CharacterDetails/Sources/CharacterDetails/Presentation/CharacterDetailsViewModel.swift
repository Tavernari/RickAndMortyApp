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
        case title(title: String)
        case info(title: String, value: String)
        case location(origin: String, location: String)
        case episodes(episodes: [String])
    }

    var items: [ViewData] = [
        .header(name: "Rick Sanchez", avatar: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", isFavorite: true),
        .title(title: "Location"),
        .location(origin: "Earth", location: "Venus"),
        .title(title: "Infos"),
        .info(title: "Status", value: "It's living"),

    ]
}

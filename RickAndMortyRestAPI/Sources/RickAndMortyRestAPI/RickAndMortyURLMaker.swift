//
//  RickAndMortyURLMaker.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import Foundation

enum RickAndMortyURLMaker {
    case characters(page: Int)
    case character(id: Int)

    var url: URL {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "rickandmortyapi.com"

        switch self {
        case .character(let id):
            urlComponent.path = "/api/character/\(id)"
        case .characters(let page):
            urlComponent.path = "/api/character/"
            urlComponent.queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        }

        return urlComponent.url!
    }
}

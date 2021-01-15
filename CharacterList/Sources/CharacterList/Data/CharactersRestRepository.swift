//
//  CharactersRestRepository.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import Combine

class CharactersRestRepository: CharactersRepository {
    func fetch(page: Int) -> Future<[Character], Error> {
        return Future<[Character], Error> { promise in
            promise(.success([
                .init(id: 1,
                          name: "Bobby Moynihan",
                          avatar: "https://rickandmortyapi.com/api/character/avatar/54.jpeg"),
                .init(id: 2,
                          name: "Victor Carvalho Tavernari",
                          avatar: "https://rickandmortyapi.com/api/character/avatar/23.jpeg"),
                .init(id: 3,
                          name: "Vanessa Tavares Tavernari",
                          avatar: "https://rickandmortyapi.com/api/character/avatar/50.jpeg"),
                .init(id: 4,
                          name: "Viviane Carvalho Tavernari",
                          avatar: "https://rickandmortyapi.com/api/character/avatar/10.jpeg"),
                .init(id: 5,
                          name: "Gilmar Tavernari",
                          avatar: "https://rickandmortyapi.com/api/character/avatar/20.jpeg"),
                .init(id: 6,
                          name: "Sandra Mara Monteiro Carvalho",
                          avatar: "https://rickandmortyapi.com/api/character/avatar/34.jpeg"),
                .init(id: 7,
                          name: "Beto Alves",
                          avatar: "https://rickandmortyapi.com/api/character/avatar/22.jpeg"),
                .init(id: 8,
                          name: "Valderez Tavares",
                          avatar: "https://rickandmortyapi.com/api/character/avatar/12.jpeg")

            ]))
        }
    }
}

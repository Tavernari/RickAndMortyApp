//
//  CharactersRestRepository.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import Combine
import RickAndMortyRestAPI

class CharactersRestRepository: CharactersRepository {
    private var allCharactersCancelable: AnyCancellable?
    func fetch(page: Int) -> Future<[CharacterList.Character], Error> {
        return Future<[CharacterList.Character], Error> { promise in
            self.allCharactersCancelable = RickAndMortyRestAPI.allCharacters(page: page).sink { error in
                print(error)
            } receiveValue: { fetchResponse in
                promise(.success( fetchResponse
                                    .results
                                    .map { char in
                                        return Character(id: char.id,
                                                         name: char.name,
                                                         avatar: char.image)
                                    }
                    )
                )
            }
        }
    }
}

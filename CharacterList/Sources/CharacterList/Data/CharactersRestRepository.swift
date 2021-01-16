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
            self.allCharactersCancelable = RickAndMortyRestAPI.allCharacters(page: page).sink { completion in
                switch completion {
                case .failure(let error):
                    promise(.failure(error))
                default: break
                }
            } receiveValue: { fetchResponse in
                let characters = fetchResponse.results.map { char in
                        return Character(id: char.id,
                                         name: char.name,
                                         avatar: char.image)
                }

                promise(.success( characters ))
            }
        }
    }
}

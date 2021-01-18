//
//  CharactersRestRepository.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import Combine
import RickAndMortyRestAPI
import Shared

class CharactersRestRepository: CharactersRepository {
    
    private var allCharactersCancelable: AnyCancellable?
    func fetch(page: Int) -> Future<[Character], CharacterListError> {
        return Future<[Character], CharacterListError> { promise in
            self.allCharactersCancelable = RickAndMortyRestAPI.allCharacters(page: page).sink { completion in
                switch completion {
                case .failure(let error):
                    if let apiError = error as? RickAndMortyRestAPIError, apiError == RickAndMortyRestAPIError.invalidData {
                        promise(.failure(CharacterListError.nothingToShow))
                    } else {
                        promise(.failure(CharacterListError.somethingWrong))
                    }
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

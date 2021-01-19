//
//  CharactersRestRepository.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import Combine
import RickAndMortyRestAPI
import Shared

extension StatusDTO {
    var convertedStatus: Status {
        switch self {
        case .alive:
            return .alive
        case .dead:
            return .dead
        case .unknown:
            return .unknown
        }
    }
}

extension GenderDTO {
    var convertedGender: Gender {
        switch self {
        case .female:
            return .female
        case .male:
            return .male
        default:
            return .notDefined
        }
    }
}

extension Character {
    init(characterDTO: CharacterDTO) {
        self.init(id: characterDTO.id,
                  name: characterDTO.name,
                  avatar: characterDTO.image,
                  status: characterDTO.status.convertedStatus,
                  species: characterDTO.species,
                  type: characterDTO.type,
                  gender: characterDTO.gender.convertedGender,
                  origin: characterDTO.origin.name,
                  location: characterDTO.location.name,
                  episode: characterDTO.episode)
    }
}

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
                let characters = fetchResponse.results.map( Character.init )
                promise(.success( characters ))
            }
        }
    }
}

//
//  Character+initWithDTO.swift
//  
//
//  Created by Victor C Tavernari on 20/01/21.
//

import Shared
import RickAndMortyRestAPI

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

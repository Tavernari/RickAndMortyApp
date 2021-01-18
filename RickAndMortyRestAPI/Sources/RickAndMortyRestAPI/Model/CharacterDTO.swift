//
//  CharacterDTO.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import Foundation

public struct CharacterDTO: Codable {
    public let id: Int
    public let name: String
    public let status: StatusDTO
    public let species: String
    public let type: String
    public let gender: GenderDTO
    public let origin: LocationDTO
    public let location: LocationDTO
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case image
        case episode
        case url
        case created
    }

    public init(id: Int, name: String, status: StatusDTO, species: String, type: String, gender: GenderDTO, origin: LocationDTO, location: LocationDTO, image: String, episode: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}

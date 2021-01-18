//
//  Character.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import Foundation

public struct Character {
    public let id: Int
    public let name: String
    public let avatar: String
    public let status: Status
    public let species: String
    public let type: String
    public let gender: Gender
    public let origin: String
    public let location: String
    public let episode: [String]

    public init(id: Int,
         name: String,
         avatar: String,
         status: Status,
         species: String,
         type: String,
         gender: Gender,
         origin: String,
         location: String,
         episode: [String]) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.episode = episode
    }

    public init(id: Int, name: String, avatar: String) {
        self.init(id: id,
                  name: name,
                  avatar: avatar,
                  status: .unknown,
                  species: "",
                  type: "",
                  gender: .notDefined,
                  origin: "",
                  location: "",
                  episode: [])
    }
}

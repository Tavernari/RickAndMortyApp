//
//  FetchCharactersResponse.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import Foundation

public struct FetchCharactersResponse: Codable {
    public let info: FetchCharactersInfoDTO
    public let results: [CharacterDTO]

    enum CodingKeys: String, CodingKey {
        case info
        case results
    }

    public init(info: FetchCharactersInfoDTO, results: [CharacterDTO]) {
        self.info = info
        self.results = results
    }
}


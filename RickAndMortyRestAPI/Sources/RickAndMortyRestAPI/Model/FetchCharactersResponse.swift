//
//  FetchCharactersResponse.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import Foundation

public struct FetchCharactersResponse: Codable {
    public let info: FetchCharactersInfo
    public let results: [Character]

    enum CodingKeys: String, CodingKey {
        case info
        case results
    }

    public init(info: FetchCharactersInfo, results: [Character]) {
        self.info = info
        self.results = results
    }
}


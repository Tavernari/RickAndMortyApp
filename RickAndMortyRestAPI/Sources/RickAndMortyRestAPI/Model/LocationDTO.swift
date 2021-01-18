//
//  LocationDTO.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import Foundation

public struct LocationDTO: Codable {
    public let name: String
    public let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case url
    }

    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}


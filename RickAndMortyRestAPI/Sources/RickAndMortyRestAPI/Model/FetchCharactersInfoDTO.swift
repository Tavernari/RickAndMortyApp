//
//  FetchCharactersInfoDTO.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import Foundation

public struct FetchCharactersInfoDTO: Codable {
    public let count: Int
    public let pages: Int
    public let next: String?
    public let prev: String?

    enum CodingKeys: String, CodingKey {
        case count
        case pages
        case next
        case prev
    }

    public init(count: Int, pages: Int, next: String, prev: String) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }
}

//
//  Character+mock.swift
//  
//
//  Created by Victor C Tavernari on 20/01/21.
//

import Foundation
import Shared

extension Character {
    static func mock(id: Int) -> Character {
        return .init(id: id, name: "test", avatar: "")
    }
}

//
//  Status+description.swift
//  
//
//  Created by Victor C Tavernari on 20/01/21.
//

import Shared

extension Status {
    var description: String {
        switch self {
        case .alive:
            return "It's alive"
        case .dead:
            return "It's dead"
        default:
            return "Who's know?"
        }
    }
}

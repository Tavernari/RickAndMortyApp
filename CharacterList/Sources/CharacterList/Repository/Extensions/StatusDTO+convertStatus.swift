//
//  StatusDTO+convertStatus.swift
//  
//
//  Created by Victor C Tavernari on 20/01/21.
//

import Shared
import RickAndMortyRestAPI

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

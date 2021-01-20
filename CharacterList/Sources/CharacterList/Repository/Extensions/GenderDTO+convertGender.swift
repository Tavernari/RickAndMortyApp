//
//  GenderDTO+convertGender.swift
//  
//
//  Created by Victor C Tavernari on 20/01/21.
//

import Shared
import RickAndMortyRestAPI

extension GenderDTO {
    var convertedGender: Gender {
        switch self {
        case .female:
            return .female
        case .male:
            return .male
        default:
            return .notDefined
        }
    }
}

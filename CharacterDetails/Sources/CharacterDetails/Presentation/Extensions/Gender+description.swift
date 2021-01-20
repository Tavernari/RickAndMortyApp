//
//  Gender+description.swift
//  
//
//  Created by Victor C Tavernari on 20/01/21.
//

import Shared

extension Gender {
    var description: String {
        switch self {
        case .female:
            return "Female"
        case .male:
            return "Male"
        default:
            return "Undefined"
        }
    }
}

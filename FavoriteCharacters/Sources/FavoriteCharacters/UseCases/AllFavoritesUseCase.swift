//
//  AllFavoritesUseCase.swift
//  
//
//  Created by Victor C Tavernari on 20/01/21.
//

import Foundation
import Combine
import Shared

public class AllFavoritesUseCase {
    var respository: FavoritesCharactersRepository = LocalFavoritesCharactersRepository()
    private var cancellable: AnyCancellable?

    public init() {}

    public func run() -> Future<[Character], Error> {
        return respository.get()
    }
}

//
//  CheckIfCharacterWasFavoritedUseCase.swift
//  
//
//  Created by Victor C Tavernari on 19/01/21.
//

import Foundation
import Combine
import Shared

public class CheckIfCharacterWasFavoritedUseCase {
    var respository: FavoritesCharactersRepository = LocalFavoritesCharactersRepository()
    private var cancellable: AnyCancellable?
    
    public init() {}

    public func run(character: Character) -> Future<Bool, Error> {
        return Future<Bool, Error> { promise in
            self.cancellable?.cancel()
            self.cancellable = self.respository.get().sink { (completion) in
                switch completion {
                case .failure(let error):
                    promise(.failure(error))
                case .finished:
                    promise(.success(false))
                }
            } receiveValue: { characters in
                promise(.success(characters.contains(where: {$0.id == character.id})))
            }

        }
    }
}

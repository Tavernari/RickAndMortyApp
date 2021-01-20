//
//  CharactersRepositoryMock.swift
//  
//
//  Created by Victor C Tavernari on 19/01/21.
//

import Foundation
import Combine
import Shared
@testable import CharacterList

class CharactersRepositoryMock: CharactersRepository {

    private var error: CharacterListError?
    func mockError(error: CharacterListError) {
        self.error = error
    }

    private var characters: [Character] = []
    func mockFetch(characters: [Character]) {
        self.characters = characters
    }

    func fetch(page: Int) -> Future<[Character], CharacterListError> {
        return .init { [self] promise in
            if let error = self.error {
                promise(.failure(error))
            } else {
                promise(.success(characters))
            }
        }
    }
}

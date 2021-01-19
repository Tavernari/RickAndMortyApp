//
//  FetchCaractersUseCase.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import Combine
import Shared

protocol CharactersRepository {
    func fetch(page: Int) -> Future<[Character], CharacterListError>
}

class FetchCharactersUseCase {

    var currentPage = 0
    var isLoading = false
    private let repository: CharactersRepository
    init(repository: CharactersRepository) {
        self.repository = repository
    }

    func run() -> Future<[Character], CharacterListError> {
        currentPage += 1
        return self.repository.fetch(page: currentPage)
    }
}

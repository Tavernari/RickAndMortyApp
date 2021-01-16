//
//  FetchCaractersUseCase.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import Combine

protocol CharactersRepository {
    func fetch(page: Int) -> Future<[Character], Error>
}

class FetchCharactersUseCase {

    var currentPage = -1
    var isLoading = false
    private let repository: CharactersRepository
    init(repository: CharactersRepository) {
        self.repository = repository
    }

    func run() -> Future<[Character], Error> {
        currentPage += 1
        return self.repository.fetch(page: currentPage)
    }
}

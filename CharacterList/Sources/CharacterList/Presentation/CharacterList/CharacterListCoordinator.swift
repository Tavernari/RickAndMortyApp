//
//  CharacterListCoordinator.swift
//  
//
//  Created by Victor C Tavernari on 14/01/21.
//

import UIKit
import Shared

public protocol CharacterListCoordinatorDelegate: class {
    func showDetail(from: CharacterListCoordinator, characterId: Int)
}

public class CharacterListCoordinator: Coordinator {
    public weak var delegate: CharacterListCoordinatorDelegate?
    public var childrens: [Coordinator] = []

    private let navigationController: UINavigationController
    required public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let vc = CharacterListViewController()
        vc.delegate = self
        let repository = CharactersRestRepository()
        let useCase = FetchCharactersUseCase(repository: repository)
        vc.viewModel = CharacterListViewModel(fetchCaractersUseCase: useCase)
        
        self.navigationController.viewControllers = [vc]
    }
}

extension CharacterListCoordinator: CharacterListViewControllerDelegate {
    func selected(from: CharacterListViewController, characterId: Int) {
        self.delegate?.showDetail(from: self, characterId: characterId)
    }
}

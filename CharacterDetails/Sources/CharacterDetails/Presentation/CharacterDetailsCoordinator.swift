//
//  File.swift
//  
//
//  Created by Victor C Tavernari on 17/01/21.
//

import UIKit
import Shared

public class CharacterDetailsCoordinator: Coordinator {
    public var childrens: [Coordinator] = []

    public var character: Character!
    private let navigationController: UINavigationController
    public required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let vc = CharacterDetailsViewController()
        let favoriteCharacterAdapter = FavoriteCharactersAdapter()
        vc.viewModel = CharacterDetailsViewModel(character: character,
                                                 favoriteCharacterAdapter: favoriteCharacterAdapter)
        self.navigationController.pushViewController(vc, animated: true)
    }
}

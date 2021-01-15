//
//  CharacterListCoordinator.swift
//  
//
//  Created by Victor C Tavernari on 14/01/21.
//

import UIKit

public class CharacterListCoordinator: Coordinator {
    var childrens: [Coordinator] = []

    private let navigationController: UINavigationController
    required public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let vc = CharacterListViewController()
        self.navigationController.viewControllers = [vc]
    }
}

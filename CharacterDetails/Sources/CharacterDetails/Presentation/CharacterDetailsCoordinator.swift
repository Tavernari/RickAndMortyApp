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

    public var characterId: Int = -1
    private let navigationController: UINavigationController
    public required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let vc = CharacterDetailsViewController()
        self.navigationController.pushViewController(vc, animated: true)
    }
}

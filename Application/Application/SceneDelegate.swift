//
//  SceneDelegate.swift
//  Application
//
//  Created by Victor C Tavernari on 20/01/21.
//

import UIKit
import CharacterList
import CharacterDetails
import Shared

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    lazy var navigationController = UINavigationController()
    lazy var characterListCoordinator = CharacterListCoordinator(navigationController: navigationController)


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        self.window = .init(windowScene: windowScene)
        characterListCoordinator.delegate = self
        characterListCoordinator.start()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}

extension SceneDelegate: CharacterListCoordinatorDelegate {
    func showDetail(from: CharacterListCoordinator, character: Character) {
        let coordinator = CharacterDetailsCoordinator(navigationController: navigationController)
        coordinator.character = character
        coordinator.start()
    }
}


//
//  Coordinator.swift
//  
//
//  Created by Victor C Tavernari on 14/01/21.
//

import UIKit

public protocol Coordinator {
    var childrens: [Coordinator] { get }
    init(navigationController: UINavigationController)
    func start()
}

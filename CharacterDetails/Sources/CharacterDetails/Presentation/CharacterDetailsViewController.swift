//
//  CharacterDetailsViewController.swift
//  
//
//  Created by Victor C Tavernari on 17/01/21.
//

import UIKit
import Shared

class CharacterDetailsViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(CharacterDetailsHeaderCell.self,
                           forCellReuseIdentifier: CharacterDetailsHeaderCell.reuseIdentifier)
        tableView.register(CharacterDetailsEpisodesCell.self,
                           forCellReuseIdentifier: CharacterDetailsEpisodesCell.reuseIdentifier)
        tableView.register(CharacterDetailsInfoViewCell.self,
                           forCellReuseIdentifier: CharacterDetailsInfoViewCell.reuseIdentifier)
        tableView.register(CharacterDetailsLocationViewCell.self,
                           forCellReuseIdentifier: CharacterDetailsLocationViewCell.reuseIdentifier)
        tableView.register(CharacterDetailsTitleViewCell.self,
                           forCellReuseIdentifier: CharacterDetailsTitleViewCell.reuseIdentifier)

        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.bounces = false
        tableView.bouncesZoom = false

        tableView.dataSource = self.dataSource

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsMultipleSelection = false
        tableView.allowsSelection = false
        return tableView
    }()

    lazy var dataSource = TableViewDataSource.make(for: viewModel.items, withViewModel: viewModel)

    var viewModel: CharacterDetailsViewModel!

    fileprivate func applyConstraints() {
        let viewSafeArea = view.safeAreaLayoutGuide
        tableView
            .leftAnchor
            .constraint(equalTo: viewSafeArea.leftAnchor)
            .isActive = true

        tableView
            .topAnchor
            .constraint(equalTo: viewSafeArea.topAnchor)
            .isActive = true

        tableView
            .bottomAnchor
            .constraint(equalTo: viewSafeArea.bottomAnchor)
            .isActive = true

        tableView
            .rightAnchor
            .constraint(equalTo: viewSafeArea.rightAnchor)
            .isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.name
        
        view.addSubview(tableView)

        applyConstraints()

        view.backgroundColor = .systemBackground
    }
}

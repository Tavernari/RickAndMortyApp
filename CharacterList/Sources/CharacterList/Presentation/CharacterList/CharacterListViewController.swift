//
//  CharacterListViewController.swift
//  
//
//  Created by Victor C Tavernari on 14/01/21.
//

import UIKit
import UIComponents

class CharacterListViewController: UIViewController {
    lazy var collectionView = UITableView()
    lazy var viewModel = CharacterListViewModel(fetchCaractersUseCase: .init(repository: CharactersRestRepository()))
    lazy var dataSource = TableViewDataSource.make(for: [], withViewModel: viewModel)

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true

        collectionView.register(CharacterListCell.self,
                                forCellReuseIdentifier: CharacterListCell.reuseIdentifier)
        collectionView.separatorStyle = .none
        collectionView.rowHeight = UITableView.automaticDimension
        collectionView.estimatedRowHeight = 400
        collectionView.delegate = self
        collectionView.bounces = true
        collectionView.bouncesZoom = true

        collectionView.dataSource = self.dataSource

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = false
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        viewModel.onUpdated = { state in
            switch state {
            case .loading:
                break
            case .failed:
                break
            case .done:
                self.dataSource.models = self.viewModel.items
                self.collectionView.reloadData()
            }
        }

        viewModel.fetchCharacters()

    }
}

extension CharacterListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            viewModel.fetchCharacters()
        }
    }
}

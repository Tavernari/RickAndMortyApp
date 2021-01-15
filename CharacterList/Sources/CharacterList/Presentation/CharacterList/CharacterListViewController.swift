//
//  CharacterListViewController.swift
//  
//
//  Created by Victor C Tavernari on 14/01/21.
//

import UIKit
import UIComponents

class CharacterListViewController: UIViewController {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: verticalFlowLayout)
    lazy var viewModel = CharacterListViewModel()
    lazy var dataSource = TableViewDataSource.make(for: [])

    lazy var verticalFlowLayout: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.estimatedItemSize = .init(width: 300, height: 300)
        flow.footerReferenceSize = .init(width: 0, height: 40)
        flow.headerReferenceSize = .init(width: 0, height: 10)
        flow.minimumLineSpacing = 40
        return flow
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true

        collectionView.register(CharacterListCell.self,
                                forCellWithReuseIdentifier: CharacterListCell.reuseIdentifier)

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
                self.dataSource = .make(for: self.viewModel.items)
                self.collectionView.dataSource = self.dataSource
                self.collectionView.reloadData()
            }
        }

        viewModel.fetchCharacters()

        view.backgroundColor = .white
        collectionView.backgroundColor = .white
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.fetchCharacters()

    }
}

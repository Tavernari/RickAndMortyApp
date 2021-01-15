//
//  TableViewDataSource.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import UIKit

class TableViewDataSource<Model, Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource {
    typealias CellConfigurator = (Model, Cell) -> Void

    var models: [Model]

    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    init(models: [Model],
         reuseIdentifier: String,
         cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        )

        guard let genericCell = cell as? Cell else {
            return cell
        }

        cellConfigurator(model, genericCell)

        return genericCell
    }
}

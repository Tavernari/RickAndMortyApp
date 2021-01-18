//
//  TableViewDataSource.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import UIKit

public class TableViewDataSource<Model, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
    public typealias IdentifierByModelGenerator = (Model) -> String
    public typealias CellConfigurator = (Model, Cell, IndexPath) -> Void

    public var models: [Model]

    private var reuseIdentifier: String?
    private var reuseIdentifierGenerator: IdentifierByModelGenerator?
    private let cellConfigurator: CellConfigurator

    public init(models: [Model],
                reuseIdentifier: String,
                cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }

    public init(models: [Model],
                reuseIdentifierGenerator: @escaping IdentifierByModelGenerator,
                cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifierGenerator = reuseIdentifierGenerator
        self.cellConfigurator = cellConfigurator
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let identifier = reuseIdentifier ?? reuseIdentifierGenerator?(model) else {
            fatalError("Invalid cell reuse identifier")
        }
        let cell = tableView.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath
        )

        guard let genericCell = cell as? Cell else {
            return cell
        }

        cellConfigurator(model, genericCell, indexPath)

        return genericCell
    }
}

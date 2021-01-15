//
//  File.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import Foundation

extension TableViewDataSource where Model == CharacterListViewModel.ViewData, Cell == CharacterListCell {
    static func make(for models: [CharacterListViewModel.ViewData]) -> TableViewDataSource {
        return TableViewDataSource(
            models: models,
            reuseIdentifier: CharacterListCell.reuseIdentifier
        ) { (model, cell) in
            cell.render(name: model.name, avatarImage: model.imagePath)
        }
    }
}

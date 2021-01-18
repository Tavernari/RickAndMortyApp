//
//  TableViewDataSource+makeCell.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import Foundation
import Shared

extension TableViewDataSource where Model == CharacterListViewModel.ViewData, Cell == CharacterListCell {
    static func make(for models: [CharacterListViewModel.ViewData],
                     withViewModel viewModel: CharacterListViewModel) -> TableViewDataSource {
        return TableViewDataSource(
            models: models,
            reuseIdentifier: CharacterListCell.reuseIdentifier
        ) { (model, cell, indexPath) in
            let index = indexPath.item
            cell.isFavorite = viewModel.wasFavorited(index: index)
            cell.onFavoriteTouched = {
                if cell.isFavorite {
                    viewModel.favorite(index: index)
                } else {
                    viewModel.unfavorite(index: index)
                }
            }
            cell.render(name: model.name, avatarImage: model.imagePath)
        }
    }
}

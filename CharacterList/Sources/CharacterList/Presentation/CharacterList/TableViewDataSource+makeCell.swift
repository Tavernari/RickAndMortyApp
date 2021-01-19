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
            
            _ = viewModel.wasFavorited(index: index).sink { completion in
                switch completion {
                case .failure:
                    cell.isFavorite = false
                default: break
                }
            } receiveValue: { value in
                cell.isFavorite = value
            }

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

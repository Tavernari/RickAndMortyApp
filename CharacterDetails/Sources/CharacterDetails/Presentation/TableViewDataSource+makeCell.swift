//
//  TableViewDataSource+makeCell.swift
//  
//
//  Created by Victor C Tavernari on 18/01/21.
//

import UIKit
import Shared

extension CharacterDetailsViewModel.ViewData {
    var reuseIdentifier: String {
        switch self {
        case .episodes:
            return CharacterDetailsEpisodesCell.reuseIdentifier
        case .header:
            return CharacterDetailsHeaderCell.reuseIdentifier
        case .info:
            return CharacterDetailsInfoViewCell.reuseIdentifier
        }
    }
}

extension TableViewDataSource where Model == CharacterDetailsViewModel.ViewData, Cell == UITableViewCell {
    static func make(for models: [CharacterDetailsViewModel.ViewData],
                     withViewModel viewModel: CharacterDetailsViewModel) -> TableViewDataSource {
        return TableViewDataSource(
            models: models,
            reuseIdentifierGenerator: { $0.reuseIdentifier }
        ) { (model, cell, indexPath) in

            switch model {
            case let .info(title, value):
                guard let cell = cell as? CharacterDetailsInfoViewCell else { return }
                cell.title = title
                cell.value = value

            case let .episodes(episodes):
                guard let cell = cell as? CharacterDetailsEpisodesCell else { return }
                cell.episodes = episodes

            case let .header(name, avatar, isFavorite):
                guard let cell = cell as? CharacterDetailsHeaderCell else { return }
                cell.render(name: name, avatarImage: avatar)
                cell.isFavorite = isFavorite
            }
        }
    }
}

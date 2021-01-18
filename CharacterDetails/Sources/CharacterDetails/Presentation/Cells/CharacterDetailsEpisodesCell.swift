//
//  CharacterDetailsEpisodesCell.swift
//  
//
//  Created by Victor C Tavernari on 18/01/21.
//

import UIKit

class CharacterDetailsEpisodesCell: UITableViewCell {
    static let reuseIdentifier = "CharacterDetailsEpisodesCell"
    override var reuseIdentifier: String? { CharacterDetailsEpisodesCell.reuseIdentifier }

    var episodes: [String] = [] {
        didSet {

        }
    }
}

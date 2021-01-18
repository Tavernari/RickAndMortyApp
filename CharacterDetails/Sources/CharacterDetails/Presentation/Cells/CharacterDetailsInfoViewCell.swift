//
//  CharacterDetailsInfoViewCell.swift
//  
//
//  Created by Victor C Tavernari on 18/01/21.
//

import UIKit

class CharacterDetailsInfoViewCell: UITableViewCell {
    static let reuseIdentifier = "CharacterDetailsInfoViewCell"
    override var reuseIdentifier: String? { CharacterDetailsInfoViewCell.reuseIdentifier }

    var title: String = "" {
        didSet {

        }
    }

    var value: String = "" {
        didSet {
            
        }
    }
}


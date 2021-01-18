//
//  CharacterDetailsTitleViewCell.swift
//  
//
//  Created by Victor C Tavernari on 18/01/21.
//

import UIKit

class CharacterDetailsTitleViewCell: UITableViewCell {
    static let reuseIdentifier = "CharacterDetailsTitleViewCell"
    override var reuseIdentifier: String? { CharacterDetailsInfoViewCell.reuseIdentifier }

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .black)
        label.textColor = .systemOrange
        return label
    }()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        titleLabel.text = title
    }

}


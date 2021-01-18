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
            titleLabel.text = title
        }
    }

    var value: String = "" {
        didSet {
            valueLabel.text = value
        }
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .systemYellow
        return label
    }()

    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 23, weight: .regular)
        label.numberOfLines = -1
        label.textColor = .systemTeal
        return label
    }()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        addSubview(titleLabel)
        addSubview(valueLabel)

        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true

        valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -2).isActive = true
        valueLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        valueLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true

        titleLabel.text = title
        valueLabel.text = value
    }
    
}


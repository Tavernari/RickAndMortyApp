//
//  CharacterDetailsLocationViewCell.swift
//  
//
//  Created by Victor C Tavernari on 18/01/21.
//

import UIKit

class CharacterDetailsLocationViewCell: UITableViewCell {
    static let reuseIdentifier = "CharacterDetailsLocationViewCell"
    override var reuseIdentifier: String? { CharacterDetailsInfoViewCell.reuseIdentifier }

    var origin: String = "" {
        didSet {
            originLabel.text = origin
        }
    }

    var location: String = "" {
        didSet {
            locationLabel.text = location
        }
    }

    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 23, weight: .regular)
        label.textColor = .systemTeal
        return label
    }()

    lazy var originLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 23, weight: .regular)
        label.textColor = .systemTeal
        return label
    }()

    lazy var locationSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = -1
        label.textColor = .systemYellow
        label.text = "Nowadays"
        return label
    }()

    lazy var originSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = -1
        label.textColor = .systemYellow
        label.text = "Origin"
        return label
    }()

    lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 32
        return stack
    }()

    lazy var locationStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()

    lazy var originStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()

    lazy var planetIcon: UIImageView = {
        let heartSizeConfig = UIImage.SymbolConfiguration(pointSize: 8, weight: .light, scale: .small)
        let image = UIImage(systemName: "location.viewfinder", withConfiguration: heartSizeConfig)!.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image:image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        locationStack.addArrangedSubview(locationSubtitleLabel)
        locationStack.addArrangedSubview(locationLabel)

        originStack.addArrangedSubview(originSubtitleLabel)
        originStack.addArrangedSubview(originLabel)

        mainStack.addArrangedSubview(originStack)
        mainStack.addArrangedSubview(locationStack)

        addSubview(planetIcon)
        addSubview(mainStack)

        planetIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true

        mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        mainStack.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20).isActive = true
        mainStack.leftAnchor.constraint(equalTo: planetIcon.rightAnchor, constant: 16).isActive = true

        planetIcon.widthAnchor.constraint(equalToConstant: 32).isActive = true
        planetIcon.heightAnchor.constraint(equalToConstant: 32).isActive = true
        planetIcon.centerYAnchor.constraint(equalTo: mainStack.centerYAnchor).isActive = true

        locationLabel.text = location
        originLabel.text = origin
    }

}


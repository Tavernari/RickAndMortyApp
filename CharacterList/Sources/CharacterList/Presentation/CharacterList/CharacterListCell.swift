//
//  CharacterListCell.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import UIKit
import UIComponents

class CharacterListCell: UITableViewCell {
    static let reuseIdentifier = "CharacterListCell"
    override var reuseIdentifier: String? { CharacterListCell.reuseIdentifier }

    private lazy var characterTitleAvatarView = CharacterTitleAvatarView()

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        characterTitleAvatarView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(characterTitleAvatarView)

        contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        contentView.layer.shadowOffset = .init(width: 0, height: 5)
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOpacity = 0.15
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        characterTitleAvatarView.setContentCompressionResistancePriority(.init(1000), for: .vertical)

        characterTitleAvatarView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        characterTitleAvatarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        characterTitleAvatarView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        characterTitleAvatarView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        characterTitleAvatarView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true

        characterTitleAvatarView.updateConstraints()
    }

    func render(name: String, avatarImage: String) {
        characterTitleAvatarView.render(name: name, avatarImage: avatarImage)
    }

    var isFavorite: Bool {
        get {  characterTitleAvatarView.isFavorited }
        set { characterTitleAvatarView.isFavorited = newValue }
    }

    var onFavoriteTouched: (()->Void)? {
        get { characterTitleAvatarView.onFavoriteTouched }
        set { characterTitleAvatarView.onFavoriteTouched = newValue }
    }

    func clear() {
        characterTitleAvatarView.clear()
    }
}

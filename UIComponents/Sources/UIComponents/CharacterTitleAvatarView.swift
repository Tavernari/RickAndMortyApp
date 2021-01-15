//
//  CharacterTitleAvatarView.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import UIKit

public class CharacterTitleAvatarView: UIView {
    private lazy var characterNameLabelContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        return view
    }()

    private lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()

    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        addSubview(characterImageView)

        characterImageView.addSubview(characterNameLabelContainer)
        characterNameLabelContainer.addSubview(characterNameLabel)
    }

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()

        characterNameLabel.setContentCompressionResistancePriority(.init(1), for: .horizontal)
        characterNameLabelContainer.setContentCompressionResistancePriority(.init(2), for: .horizontal)

        characterNameLabel.setContentHuggingPriority(.init(1), for: .horizontal)
        characterNameLabelContainer.setContentHuggingPriority(.init(2), for: .horizontal)

        characterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        characterImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        characterImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        characterImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        characterNameLabelContainer.leftAnchor.constraint(equalTo: characterImageView.leftAnchor).isActive = true
        characterNameLabelContainer.bottomAnchor.constraint(equalTo: characterImageView.bottomAnchor).isActive = true
        characterNameLabelContainer.rightAnchor.constraint(equalTo: characterImageView.rightAnchor).isActive = true

        characterNameLabel.topAnchor.constraint(equalTo: characterNameLabelContainer.topAnchor, constant: 8).isActive = true
        characterNameLabel.leftAnchor.constraint(equalTo: characterNameLabelContainer.leftAnchor, constant: 16).isActive = true
        characterNameLabel.rightAnchor.constraint(equalTo: characterNameLabelContainer.rightAnchor, constant: -16).isActive = true
        characterNameLabel.bottomAnchor.constraint(equalTo: characterNameLabelContainer.bottomAnchor, constant: -8).isActive = true
    }

    public func render(name: String, avatarImage: String) {
        if let url = URL(string: avatarImage) {
            characterImageView.load(url: url)
        }
        characterNameLabel.text = name
    }
}

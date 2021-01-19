//
//  CharacterTitleAvatarView.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import UIKit

public class CharacterTitleAvatarView: UIView {

    public typealias TouchedCallback = (()->Void)

    public var onFavoriteTouched: TouchedCallback? {
        get { favoriteButton.onFavoriteTouched }
        set { favoriteButton.onFavoriteTouched = newValue }
    }

    private lazy var favoriteButton: HeartButton = {
        let button = HeartButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = .init(width: 0, height: 5)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.4
        return button
    }()

    public var isFavorited: Bool {
        get {
            return !favoriteButton.isRedHeartHidden
        }
    }

    public func favorite(animated: Bool = true) {
        if !animated {
            favoriteButton.openHeart()
        }

        favoriteButton.isRedHeartHidden = false
    }

    public func unfavorite(animated: Bool = true) {
        if !animated {
            favoriteButton.closeHeart()
        }

        favoriteButton.isRedHeartHidden = true
    }

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .lightGray
        activityIndicator.stopAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

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
        label.textColor = .purple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()

    private var currentAvatarURL: String = ""

    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        addSubview(characterImageView)
        addSubview(favoriteButton)
        characterImageView.backgroundColor = .gray

        characterImageView.addSubview(activityIndicator)
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
        characterNameLabel.rightAnchor.constraint(equalTo: favoriteButton.leftAnchor, constant: -4).isActive = true
        characterNameLabel.bottomAnchor.constraint(equalTo: characterNameLabelContainer.bottomAnchor, constant: -8).isActive = true

        activityIndicator.centerYAnchor.constraint(equalTo: characterImageView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: characterImageView.centerXAnchor).isActive = true

        favoriteButton.bottomAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: -16).isActive = true
        favoriteButton.rightAnchor.constraint(equalTo: characterImageView.rightAnchor, constant: -16).isActive = true
    }

    public func render(name: String, avatarImage: String) {
        if let url = URL(string: avatarImage), currentAvatarURL != avatarImage  {
            currentAvatarURL = avatarImage
            characterImageView.image = nil
            activityIndicator.startAnimating()
            characterImageView.load(url: url, onFinished: activityIndicator.stopAnimating)
        }
        characterNameLabel.text = name
    }

    public func clear() {
        currentAvatarURL = ""
        characterImageView.image = nil
        characterNameLabel.text = ""
    }

    public func changeToDetailStyle() {
        characterNameLabelContainer.isHidden = true
    }
}

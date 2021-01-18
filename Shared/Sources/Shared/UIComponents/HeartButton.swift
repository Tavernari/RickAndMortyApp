//
//  HeartButton.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import UIKit

public class HeartButton: UIControl {

    var onFavoriteTouched: (()->Void)?

    private lazy var heartFilled: UIImage = {
        let heartSizeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
        return UIImage(systemName: "heart.fill", withConfiguration: heartSizeConfig)!.withRenderingMode(.alwaysTemplate)
    }()

    private lazy var whiteHeart: UIImageView = {
        let imageView = UIImageView(image: heartFilled)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
    }()

    private lazy var redHeart: UIImageView = {
        let imageView = UIImageView(image: heartFilled)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .red
        return imageView
    }()

    private var redHeartOpenWidthConstraint: NSLayoutConstraint?
    private var redHeartOpenHeightConstraint: NSLayoutConstraint?

    private var redHeartCloseWidthConstraint: NSLayoutConstraint?
    private var redHeartCloseHeightConstraint: NSLayoutConstraint?

    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        addSubview(whiteHeart)
        addSubview(redHeart)
    }

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()

        whiteHeart.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        whiteHeart.topAnchor.constraint(equalTo: topAnchor).isActive = true
        whiteHeart.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        whiteHeart.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

        redHeart.setContentHuggingPriority(.init(1), for: .horizontal)
        redHeart.setContentHuggingPriority(.init(1), for: .vertical)
        redHeart.setContentCompressionResistancePriority(.init(1), for: .horizontal)
        redHeart.setContentCompressionResistancePriority(.init(1), for: .vertical)

        redHeartOpenWidthConstraint = redHeart.widthAnchor.constraint(equalTo: whiteHeart.widthAnchor, multiplier: 1.1)
        redHeartOpenHeightConstraint = redHeart.heightAnchor.constraint(equalTo: whiteHeart.heightAnchor, multiplier: 1.1)

        redHeartCloseWidthConstraint = redHeart.widthAnchor.constraint(equalToConstant: 0)
        redHeartCloseHeightConstraint = redHeart.heightAnchor.constraint(equalToConstant: 0)

        redHeartCloseWidthConstraint?.isActive = true
        redHeartCloseHeightConstraint?.isActive = true

        redHeart.centerXAnchor.constraint(equalTo: whiteHeart.centerXAnchor).isActive = true
        redHeart.centerYAnchor.constraint(equalTo: whiteHeart.centerYAnchor).isActive = true

        if isRedHeartHidden {
            closeHeart()
        } else {
            openHeart()
        }

        self.addTarget(self, action: #selector(touchUpInSide), for: .touchUpInside)
    }

    @objc func touchUpInSide() {
        isRedHeartHidden = !isRedHeartHidden
        onFavoriteTouched?()
    }

    var isRedHeartHidden: Bool = true {
        didSet {
            if isRedHeartHidden {
                closeHeart()
            } else {
                openHeart()
            }
        }
    }

    private func removeAllAnimations() {
        redHeart.layer.removeAllAnimations()
        whiteHeart.layer.removeAllAnimations()
        layer.removeAllAnimations()
    }

    private func closeHeart() {
        removeAllAnimations()
        layoutIfNeeded()
        redHeartOpenWidthConstraint?.isActive = false
        redHeartOpenHeightConstraint?.isActive = false
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            self.redHeartCloseWidthConstraint?.isActive = true
            self.redHeartCloseHeightConstraint?.isActive = true
            self.setNeedsLayout()
        })
    }

    private func openHeart() {
        removeAllAnimations()
        layoutIfNeeded()
        redHeartCloseWidthConstraint?.isActive = false
        redHeartCloseHeightConstraint?.isActive = false
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseOut, animations: {
            self.redHeartOpenWidthConstraint?.isActive = true
            self.redHeartOpenHeightConstraint?.isActive = true
            self.layoutIfNeeded()
        })
    }
}

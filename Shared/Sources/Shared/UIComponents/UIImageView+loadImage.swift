//
//  File.swift
//  
//
//  Created by Victor C Tavernari on 15/01/21.
//

import UIKit

extension UIImageView {
    func load(url: URL, onFinished: (()->Void)? = nil) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        onFinished?()
                        self?.image = image
                        self?.updateConstraints()
                    }
                }
            }
        }
    }
}

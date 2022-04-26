//
//  UIImageView+extension.swift
//  RecipeSearch
//
//  Created by LapStore on 25/04/2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String) {
        let url = URL(string: urlString)
        self.kf.setImage(with: url,
                         placeholder: UIImage(named: ""),
                         options: [.transition(.fade(0.5))],
                         progressBlock: nil, completionHandler: { [weak self](result) in
                            switch result {
                            case .failure:
                                self?.image =  UIImage(named: "")
                            default:
                                break
                            }
                         })
    }
}

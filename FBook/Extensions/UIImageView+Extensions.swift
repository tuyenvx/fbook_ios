//
//  UIImageView+Extensions.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/11/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Kingfisher

extension UIImageView {

    func setImage(urlString: String?, placeHolder: UIImage? = kDefaultPlaceHolder) {
        kf.cancelDownloadTask()
        if let urlString = urlString, let url = URL(string: urlString) {
            kf.setImage(with: url, placeholder: placeHolder)
        } else {
            image = placeHolder
        }
    }

}

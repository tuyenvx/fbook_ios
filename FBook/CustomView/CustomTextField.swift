//
//  CustomTextField.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {

    @IBInspectable var padding: CGFloat = 8.0
    @IBInspectable var imageSize: CGFloat = 20.0

    @IBInspectable var leftImage: UIImage? = nil {
        didSet {
            updateLeftView()
        }
    }

    @IBInspectable var rightImage: UIImage? = nil {
        didSet {
            updateRightView()
        }
    }

    private func updateLeftView() {
        if let leftImage = leftImage?.withRenderingMode(.alwaysTemplate) {
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: padding, y: 0.0, width: imageSize, height: imageSize))
            imageView.contentMode = .scaleAspectFit
            imageView.image = leftImage
            imageView.tintColor = kGrayColor
            tintColor = kGrayColor
            let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: imageSize + padding, height: imageSize))
            view.addSubview(imageView)
            view.center.y = center.y
            leftView = view
        } else {
            leftViewMode = .never
        }
    }

    private func updateRightView() {
        if let rightImage = rightImage?.withRenderingMode(.alwaysTemplate) {
            rightViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: imageSize, height: imageSize))
            imageView.contentMode = .scaleAspectFit
            imageView.image = rightImage
            imageView.tintColor = kGrayColor
            let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: imageSize + padding, height: imageSize))
            view.addSubview(imageView)
            view.center.y = center.y
            rightView = view
        } else {
            rightViewMode = .never
        }
    }

}

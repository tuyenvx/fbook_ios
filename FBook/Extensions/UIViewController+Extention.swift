//
//  UIViewController+Extention.swift
//  FBook
//
//  Created by TuyenVX on 2/8/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class func loadFromStoryBoard(_ storyboard: UIStoryboard) -> UIViewController {
        return storyboard.instantiateViewController(withIdentifier: String(describing: self))
    }
}

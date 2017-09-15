//
//  BaseTabBarController.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for: .normal)
    }
}

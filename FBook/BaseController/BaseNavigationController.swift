//
//  BaseNavigationController.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
    }

    func setUpNavigation() {
        navigationBar.barTintColor = .red
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

}

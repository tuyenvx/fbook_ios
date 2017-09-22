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
        setBackButton()
    }

    func setUpNavigation() {
        navigationBar.barTintColor = .red
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }

    func setBackButton() {
        let backButton = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationBar.backIndicatorImage = #imageLiteral(resourceName: "ic_back")
        navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "ic_back")
        navigationBar.topItem?.backBarButtonItem = backButton
    }

}

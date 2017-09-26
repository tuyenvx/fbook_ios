//
//  ShareBookViewRouter.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/25/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol ShareBookViewRouter {

    func present(viewControllerToPresent: UIViewController)
    func performSegue(withIdentifier: String)

}

class ShareBookViewRouterImpl {

    fileprivate weak var viewController: ShareBookViewController?

    init(viewController: ShareBookViewController) {
        self.viewController = viewController
    }

}

extension ShareBookViewRouterImpl: ShareBookViewRouter {

    func present(viewControllerToPresent: UIViewController) {
        viewController?.present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func performSegue(withIdentifier: String) {
        viewController?.performSegue(withIdentifier: withIdentifier, sender: self)
    }

}

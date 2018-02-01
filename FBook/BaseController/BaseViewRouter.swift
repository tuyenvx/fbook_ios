//
//  BaseViewRouter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/12/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

protocol BaseViewRouter {
    func dismiss()
}

struct BaseViewRouterImplementation {

    fileprivate weak var view: BaseViewController?

    init(view: BaseViewController?) {
        self.view = view
    }

    @discardableResult fileprivate func openSafariViewController(urlString: String) -> Bool {
        guard let url = URL(string: urlString) else {
            return false
        }
        let safariViewController = FBSafariViewController(url: url)
        view?.present(safariViewController, animated: true, completion: nil)
        return true
    }

}

extension BaseViewRouterImplementation: BaseViewRouter {
    func dismiss() {
        view?.navigationController?.dismiss(animated: true, completion: nil)
    }
}

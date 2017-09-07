//
//  Utility.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

class Utility: NSObject {

    static let shared = Utility()

    func showMessage(inViewController viewControllerShow: UIViewController? = nil,
                     title: String? = nil, message: String, okButtonTitle: String = kOKString,
                     completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let atributedMessage = NSAttributedString(string: message)
        alert.setValue(atributedMessage, forKey: "attributedMessage")
        alert.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: { (_) in
            completion?()
        }))
        let viewController = getPresentableViewController(by: viewControllerShow)
        DispatchQueue.main.async {
            viewController?.present(alert, animated: true, completion: nil)
        }
    }

    func showMessage(inViewController viewControllerShow: UIViewController? = nil,
                     title: String? = nil, message: String, okButtonTitle: String = kOKString,
                     cancelButtonTitle: String = kCancelString, okCompletion: (() -> Void)? = nil,
                     cancelCompletion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let atributedMessage = NSAttributedString(string: message)
        alert.setValue(atributedMessage, forKey: "attributedMessage")
        alert.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: { (_) in
            okCompletion?()
        }))
        alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: { (_) in
            cancelCompletion?()
        }))
        let viewController = getPresentableViewController(by: viewControllerShow)
        DispatchQueue.main.async {
            viewController?.present(alert, animated: true, completion: nil)
        }
    }

    func showNetworkError(inViewController viewControllerShow: UIViewController? = nil) {
        let message = NetworkReachability.isReachable ? kErrorSystem : kErrorNetwork
        let viewController = getPresentableViewController(by: viewControllerShow)
        showMessage(inViewController: viewController, message: message, completion: nil)
    }

    func getPresentableViewController(by viewController: UIViewController?) -> UIViewController? {
        let viewControllerReturn: UIViewController?
        if let viewController = viewController {
            viewControllerReturn = getVisibleViewController(from: viewController)
        } else {
            viewControllerReturn = getVisibleViewControllerOfWindow()
        }
        return viewControllerReturn
    }

    func getVisibleViewControllerOfWindow() -> UIViewController? {
        guard let viewController = appDelegate?.window?.rootViewController else {
            return nil
        }
        return getVisibleViewController(from: viewController)
    }

    func getVisibleViewController(from viewController: UIViewController?) -> UIViewController? {
        if let navigationViewController = viewController as? UINavigationController {
            return getVisibleViewController(from: navigationViewController.visibleViewController)
        } else if let tabbarViewController = viewController as? UITabBarController {
            return getVisibleViewController(from: tabbarViewController.selectedViewController)
        } else {
            if let presentedViewController = viewController?.presentedViewController {
                return getVisibleViewController(from: presentedViewController)
            } else {
                return viewController
            }
        }
    }

}

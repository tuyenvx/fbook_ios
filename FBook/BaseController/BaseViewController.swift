//
//  BaseViewController.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    fileprivate var basePresenter: BasePresenter?
    fileprivate var baseConfigurator = BaseViewConfiguratorImplementation()

    override func viewDidLoad() {
        super.viewDidLoad()
        basePresenter = baseConfigurator.configure(view: self)
        setDefaultRightButtons()
    }

    func setDefaultRightButtons() {
        let menuButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_more"), style: .plain, target: self,
            action: #selector(menuButtonTapped(_:)))
        navigationItem.rightBarButtonItems = [getSpacer(), menuButton]
    }

    func setBackButton() {
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back"), style: .plain, target: self,
            action: #selector(backButtonTapped(_:)))
        navigationItem.leftBarButtonItems = [getSpacer(), backButton]
    }

    fileprivate func getSpacer(width: CGFloat = -8) -> UIBarButtonItem {
        // This is trick to reduce margin
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = width
        return negativeSpacer
    }

    func menuButtonTapped(_ sender: Any) {
        var senderFrame = CGRect.zero
        if let senderView = sender as? UIView, let window = application.keyWindow {
            senderFrame = senderView.convert(senderView.frame, to: window)
        }
        basePresenter?.menuButtonTapped(senderFrame: senderFrame)
    }

    func backButtonTapped(_ sender: UIBarButtonItem) {
        basePresenter?.backButtonTapped()
    }

}

extension BaseViewController: BaseView {

}

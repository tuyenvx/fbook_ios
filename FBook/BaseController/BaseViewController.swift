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
        guard let heightNavigationBar = navigationController?.navigationBar.frame.height else {
            return
        }
        let widthItems: CGFloat = 30.0
        let workSpaceButton = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: widthItems,
            height: heightNavigationBar)))
        workSpaceButton.setImage(#imageLiteral(resourceName: "ic_workspace"), for: .normal)
        workSpaceButton.addTarget(self, action: #selector(workSpaceButtonTapped(_:)), for: .touchUpInside)
        let menuButton = UIButton(frame: CGRect(origin: CGPoint(x: workSpaceButton.frame.width, y: 0),
            size: CGSize(width: widthItems, height: heightNavigationBar)))
        menuButton.setImage(#imageLiteral(resourceName: "ic_more"), for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonTapped(_:)), for: .touchUpInside)
        let leftViewSize = CGSize(width: menuButton.frame.origin.x + menuButton.frame.width,
            height: heightNavigationBar)
        let leftView = UIView(frame: CGRect(origin: .zero, size: leftViewSize))
        leftView.addSubview(workSpaceButton)
        leftView.addSubview(menuButton)
        navigationItem.rightBarButtonItems = [getSpacer(width: -10), UIBarButtonItem(customView: leftView)]
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

    func workSpaceButtonTapped(_ sender: Any) {
        basePresenter?.workspaceButtonTapped()
    }

    func backButtonTapped(_ sender: UIBarButtonItem) {
        basePresenter?.backButtonTapped()
    }

}

extension BaseViewController: BaseView {

}

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
    }

    func setDefaultRightButtons() {
        guard let heightButton = navigationController?.navigationBar.frame.height else {
            return
        }
        let widthButton: CGFloat = 30
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: widthButton, height: heightButton)))
        button.setImage(#imageLiteral(resourceName: "ic_more"), for: .normal)
        button.addTarget(self, action: #selector(menuButtonTapped(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }

    @objc func menuButtonTapped(_ sender: Any) {
        var senderFrame = CGRect.zero
        if let senderView = sender as? UIView, let window = application.keyWindow {
            senderFrame = senderView.convert(senderView.frame, to: window)
        }
        basePresenter?.menuButtonTapped(senderFrame: senderFrame)
    }

    func cancelButtonTapped() {
        basePresenter?.dismiss()
    }

}

extension BaseViewController: BaseView {

}

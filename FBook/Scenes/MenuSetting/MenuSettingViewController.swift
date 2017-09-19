//
//  MenuSettingViewController.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/12/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class MenuSettingViewController: UIViewController {

    @IBOutlet fileprivate weak var menuView: UIView!
    @IBOutlet fileprivate weak var backgroundButton: UIButton!

    var presenter: MenuSettingPresenter?
    var configurator: MenuSettingConfigurator?

    @IBOutlet fileprivate weak var toplayoutConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(self)
        hideView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animationShowView()
    }

    fileprivate func hideView() {
        backgroundButton.alpha = 0.0
        let viewSize = menuView.frame.size
        menuView.alpha = 0.5
        let translateTransform = CGAffineTransform(translationX: viewSize.width / 2, y: -viewSize.height / 2)
        menuView.transform = translateTransform.scaledBy(x: kZeroFloat, y: kZeroFloat)
    }

    fileprivate func animationShowView() {
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.menuView.transform = .identity
            self.backgroundButton.alpha = 1
            self.menuView.alpha = 1
        }, completion: nil)
    }

    @IBAction fileprivate func feedbackButtonTapped(_ sender: Any) {
        presenter?.didSelectFeedback()
    }

    @IBAction fileprivate func moreToolsButtonTapped(_ sender: Any) {
        presenter?.didSelectMoreTools()
    }

    @IBAction fileprivate func dismissButtonTapped(_ sender: Any) {
        presenter?.didSelectDismiss()
    }

    @IBAction fileprivate func workspaceButtonTapped(_ seder: Any) {
        presenter?.didSelectWorkspace()
    }
}

extension MenuSettingViewController: MenuSettingView {

    func updateLayout(senderFrame: CGRect) {
        if senderFrame == .zero {
            let defaultTopConstraint: CGFloat = 60.0
            toplayoutConstraint?.constant = defaultTopConstraint
        } else {
            toplayoutConstraint?.constant = senderFrame.origin.y + senderFrame.height - 4.0
        }
    }

}

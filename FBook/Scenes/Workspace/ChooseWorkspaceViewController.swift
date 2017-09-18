//
//  ChooseWorkspaceViewController.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ChooseWorkspaceViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet fileprivate weak var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet fileprivate weak var heightTableConstraint: NSLayoutConstraint!

    var presenter: ChooseWorkspacePresenter?
    var configurator: ChooseWorkspaceConfigurator?

    override func viewDidLoad() {
        super.viewDidLoad()
        if configurator == nil {
            configurator = ChooseWorkspaceConfiguratorImplementation()
        }
        configurator?.configure(view: self)
    }

    @IBAction func dismissButtonTapped(_ sender: Any) {
        presenter?.didSelectDismiss()
    }

}

extension ChooseWorkspaceViewController: ChooseWorkspaceView {

    func showLoading() {
        loadingIndicatorView.isHidden = false
    }

    func hideLoading() {
        loadingIndicatorView.isHidden = true
    }

    func updateHeightTableView(height: CGFloat) {
        heightTableConstraint.constant = max(min(height, 400), 100)
    }

}

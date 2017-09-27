//
//  SortBookViewController.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/27/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class SortBookViewController: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var backgroundButton: UIButton!

    var configurator: SortBookConfigurator?
    var presenter: SortBookPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(viewController: self)
        presenter?.configure(tableView: tableView)
        hideView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animationShowView()
    }

    fileprivate func hideView() {
        backgroundButton.alpha = 0.0
        tableView.alpha = 0.5
        tableView.transform = CGAffineTransform.init(scaleX: kZeroFloat, y: kZeroFloat)
    }

    fileprivate func animationShowView() {
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.tableView.transform = .identity
            self.backgroundButton.alpha = 1
            self.tableView.alpha = 1
        }, completion: nil)
    }

    @IBAction func dismissButtonTapped(_ sender: Any) {
        presenter?.didSelectDismiss()
    }
}

extension SortBookViewController: SortBookView {
}

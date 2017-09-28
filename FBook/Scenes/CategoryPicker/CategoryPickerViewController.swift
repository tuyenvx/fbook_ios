//
//  CategoryPickerViewController.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/27/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class CategoryPickerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet fileprivate weak var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet fileprivate weak var heightTableConstraint: NSLayoutConstraint!

    var configurator: CategoryPickerConfigurator?
    var presenter: CategoryPickerPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(viewController: self)
        presenter?.getCategories()
    }

    @IBAction func dismissButtonTapped(_ sender: Any) {
        presenter?.didSelectDismiss()
    }

}

extension CategoryPickerViewController: CategoryPickerView {

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

//
//  HomeViewController.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/8/17.
//  Copyright (c) 2017 Framgia. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!

    var presenter: HomePresenter!
    var configurator: HomeConfigurator?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator = HomeConfiguratorImplementation()
        configurator?.configure(viewController: self)
        presenter.configure(tableView: tableView)
        presenter.getListSectionBook()
    }

}

extension HomeViewController: HomeView {

    func refreshBooks() {
        tableView.reloadData()
    }

    func showLoadBooksError(message: String) {
        Utility.shared.showMessage(message: message, completion: nil)
    }

}

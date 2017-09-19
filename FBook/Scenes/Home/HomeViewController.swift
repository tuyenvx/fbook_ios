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

    var presenter: HomePresenter?
    var configurator: HomeConfigurator?

    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchButton()
        configurator = HomeConfiguratorImplementation()
        configurator?.configure(viewController: self)
        presenter?.configure(tableView: tableView)
        presenter?.getListSectionBook()
    }

    func addSearchButton() {
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_search"), style: .plain, target: self,
            action: #selector(searchButtonTapped(_:)))
        navigationItem.leftBarButtonItem = searchButton
    }

    func searchButtonTapped(_ sender: Any) {
        presenter?.searchButtonTapped()
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

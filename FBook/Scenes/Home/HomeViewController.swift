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
        addLoginButton()
        configurator = HomeConfiguratorImplementation()
        configurator?.configure(viewController: self)
        presenter?.configure(tableView: tableView)
    }

    func addSearchButton() {
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_search"), style: .plain, target: self,
            action: #selector(searchButtonTapped(_:)))
        navigationItem.leftBarButtonItem = searchButton
    }

    func addLoginButton() {
        if User.currentUser == nil {
            let loginButton = UIBarButtonItem(title: "Login", style: .plain, target: self,
                action: #selector(loginButtonTapped(_:)))
            loginButton.tintColor = .white
            var rightButtons = navigationItem.rightBarButtonItems ?? []
            rightButtons.append(loginButton)
            navigationItem.rightBarButtonItems = rightButtons
        }
    }

    func searchButtonTapped(_ sender: Any) {
        presenter?.searchButtonTapped()
    }

    func loginButtonTapped(_ sender: Any) {
        presenter?.loginButtonTapped()
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

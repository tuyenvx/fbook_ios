//
//  AccountViewController.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/22/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class AccountViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    var configurator: AccountConfigurator?
    var presenter: AccountPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        if configurator == nil, let user = User.currentUser {
            configurator = AccountConfiguratorImplementation(user: user)
        }
        configurator?.configure(viewController: self)
        presenter?.configure(tableView: tableView)
        presenter?.fetchUserInfo()
    }

}

extension AccountViewController: AccountView {

    func refreshAccount() {
        tableView.reloadData()
    }

    func showLoadAccountError(message: String) {
        Utility.shared.showMessage(message: message, completion: nil)
    }

}

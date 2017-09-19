//
//  FollowersViewController.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class FollowersViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var presenter: FollowersPresenter?
    var configurator = FollowersConfiguratorImplementation()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(followersViewCotroller: self)
        presenter?.getListFollowersUser(tableView: tableView)
    }
}

extension FollowersViewController: FollowersView {
    func showLoadFollowersError(message: String) {
        Utility.shared.showMessage(message: message, completion: nil)
    }
}

//
//  FollowingViewController.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class FollowingViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var presenter: FollowingPresenter?
    var configurator = FollowingConfiguratorImplementation()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(followingViewCotroller: self)
        presenter?.getListFollowingUser(tableView: tableView)
    }
}

extension FollowingViewController:  FollowingView {
    func showLoadFollowingError(message: String) {
        Utility.shared.showMessage(message: message, completion: nil)
    }
}

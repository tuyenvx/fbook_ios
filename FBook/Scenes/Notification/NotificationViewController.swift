//
//  NotificationViewController.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import FirebaseCore

class NotificationViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var presenter: NotificationPresenter?
    var configurator = NotificationConfiguratorImplementation()
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(viewController: self)
        presenter?.configure(tableView: tableView)
        presenter?.getListNotifications()
    }

}

extension NotificationViewController: NotificationView {
    func refreshNotification() {
        tableView.reloadData()
    }

    func showLoadNotificationError(message: String) {
        Utility.shared.showMessage(message: message, completion: nil)
    }
}

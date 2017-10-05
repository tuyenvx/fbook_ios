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
        addEditButton()
        presenter?.fetchUserInfo()
    }

    func addEditButton() {
        let editButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_edit"), style: .plain, target: self,
                                         action: #selector(editButtonTapped(_:)))
        navigationItem.rightBarButtonItem = editButton
    }

    func addSaveButton() {
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self,
                                          action: #selector(saveButtonTapped(_:)))
        saveButton.tintColor = .white
        navigationItem.rightBarButtonItem = saveButton
    }

    @objc fileprivate func editButtonTapped(_ sender: Any) {
        presenter?.editButtonTapped(sender)
    }

    @objc fileprivate func saveButtonTapped(_ sender: Any) {
        presenter?.saveButtonTapped(sender)
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

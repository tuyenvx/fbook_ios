//
//  ProfileViewController.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController, ProfileView {

    var presenter: ProfilePresenter?
    var configurator: ProfileConfiguratorImplementation?

    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var emailLabel: UILabel!
    @IBOutlet fileprivate weak var phoneLabel: UILabel!
    @IBOutlet fileprivate weak var codeLabel: UILabel!
    @IBOutlet fileprivate weak var positionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if configurator == nil, let user = User.currentUser {
            configurator = ProfileConfiguratorImplementation(user: user, viewController: self)
        }
        configurator?.configure()
        presenter?.updateUserProfileView()
    }

    func displayUser(user: User) {
        nameLabel.text = user.name
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        codeLabel.text = user.code
        positionLabel.text = user.position
    }
}

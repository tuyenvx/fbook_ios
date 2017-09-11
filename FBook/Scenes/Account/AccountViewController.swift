//
//  AccountViewController.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import SwiftHEXColors
import RxSwift
import RxCocoa
import Kingfisher

class AccountViewController: BaseViewController, AccountView {

    var presenter: AccountPresenter?
    var configurator = AccountConfiguratorImplementation()

    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var headerAccountView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        userAvatarImage.layer.zPosition = 1
        configurator.configure(accountViewController: self)
        presenter?.updateUserInfo()
    }

    func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.headerAccountView.bounds
        gradientLayer.colors = [UIColor(hexString: "#F23031")?.cgColor as Any,
                                UIColor(hexString: "#FF6A3B")?.cgColor as Any]
        self.headerAccountView.layer.addSublayer(gradientLayer)
    }

    func displayUserInfo(user: User) {
        if user.avatar != "" {
            let avatarUrl = URL(string: user.avatar)
            userAvatarImage.kf.setImage(with: avatarUrl)
        } else {
            userAvatarImage.image = UIImage(named: "icon_user")
        }
        userAvatarImage.layer.masksToBounds = true
        userAvatarImage.layer.cornerRadius = userAvatarImage.frame.height/2
    }
}

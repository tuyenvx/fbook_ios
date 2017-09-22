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
    var configurator: AccountConfiguratorImplementation?

    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var headerAccountView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var favoriteCategoriesView: UIView!
    @IBOutlet weak var followersView: UIView!
    @IBOutlet weak var followingView: UIView!

    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var categoriesButton: UIButton!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var followButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        userAvatarImage.layer.zPosition = 1
        followButton.layer.zPosition = 1
        if configurator == nil, let user = User.currentUser {
            configurator = AccountConfiguratorImplementation()
            configurator?.configure(accountViewController: self, user: user)
        }
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
        userAvatarImage.setImage(urlString: user.avatar, placeHolder: kDefaultAvatar)
        userAvatarImage.layer.masksToBounds = true
        userAvatarImage.layer.cornerRadius = userAvatarImage.frame.height/2
    }

    @IBAction func onButtonProfileClicked(_ sender: Any) {
        presenter?.selectProfileButton()
    }

    @IBAction func onButtonCategoriesClicked(_ sender: Any) {
        presenter?.selectCategoriesButton()
    }

    @IBAction func onButtonFollowingClicked(_ sender: Any) {
        presenter?.selectFollowingButton()
    }

    @IBAction func onButtonFollowersClicked(_ sender: Any) {
        presenter?.selectFollowersButton()
    }

    func displayProfileTab() {
        updateTabView(selectButton: profileButton, selectView: profileView)
    }

    func displayCategoriesTab() {
        updateTabView(selectButton: categoriesButton,
                      selectView: self.favoriteCategoriesView)
    }

    func displayFollowersTab() {
        updateTabView(selectButton: followersButton, selectView: followersView)
    }

    func displayFollowingTab() {
        updateTabView(selectButton: followingButton, selectView: followingView)
    }

    @IBAction func onButtonFollowClicked(_ sender: Any) {
        presenter?.updateFollowButton(buttonState: !followButton.isSelected)
    }

    func followButtonEnable() {
        followButton.isSelected = false
        followButton.borderColor = .clear
        followButton.setBackgroundImage(UIImage(named: "background_button_follow"), for: .normal)
    }

    func unFollowButtonEnable() {
        followButton.isSelected = true
        followButton.setBackgroundImage(UIImage(named: ""), for: .normal)
        followButton.borderWidth = 1
        followButton.borderColor = .white
    }

    fileprivate func updateTabView(selectButton: UIButton?, selectView: UIView?) {
        [profileButton, categoriesButton, followersButton, followingButton].forEach { button in
            button?.isSelected = button == selectButton
        }
        [profileView, self.favoriteCategoriesView, followingView, followersView].forEach { view in
            view?.isHidden = view != selectView
        }
    }

    func showFollowError(message: String) {
        Utility.shared.showMessage(message: message, completion: nil)
    }

    func showFollowSuccess(message: Bool) {
//        TODO: show follow success
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter?.router.prepare(for: segue, sender: sender)
    }
}

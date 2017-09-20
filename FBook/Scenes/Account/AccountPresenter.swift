//
//  AccountPresenter.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol AccountView: class {
    func displayUserInfo(user: User)
    func displayProfileTab()
    func displayCategoriesTab()
    func displayFollowingTab()
    func displayFollowersTab()
    func followButtonEnable()
    func unFollowButtonEnable()
    func showFollowError(message: String)
    func showFollowSuccess(message: Bool)
}

protocol AccountPresenter {
    func updateUserInfo()
    func selectProfileButton()
    func selectCategoriesButton()
    func selectFollowingButton()
    func selectFollowersButton()
    func updateFollowButton(buttonState: Bool)
}

class AccountPresenterImplementation: AccountPresenter {

    fileprivate weak var view: AccountView?

    init(view: AccountView) {
        self.view = view
    }

    func updateUserInfo() {
        guard let currentUser = User.currentUser else {return}
        view?.displayUserInfo(user: currentUser)
    }

    func selectProfileButton() {
        view?.displayProfileTab()
    }

    func selectCategoriesButton() {
        view?.displayCategoriesTab()
    }

    func selectFollowingButton() {
        view?.displayFollowingTab()
    }

    func selectFollowersButton() {
        view?.displayFollowersTab()
    }

    func updateFollowButton(buttonState: Bool) {
        weak var weakSelf = self
        AlertHelper.showLoading()
        UsersProvider.followUser(userId: 1).on(failed: { error in
            AlertHelper.hideLoading()
            weakSelf?.view?.showFollowError(message: error.message)
        }, completed: {
            AlertHelper.hideLoading()
        }, value: { status in
            weakSelf?.view?.showFollowSuccess(message: status)
            (buttonState && status) ? weakSelf?.view?.unFollowButtonEnable() : weakSelf?.view?.followButtonEnable()
        }).start()
    }
}

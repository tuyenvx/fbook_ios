//
//  ProfilePresenter.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol ProfileView: class {
    func displayUser(user: User)
}

protocol ProfilePresenter {
    func updateUserProfileView()
}

class ProfilePresenterImplementation: ProfilePresenter {
    fileprivate weak var view: ProfileView?
    fileprivate var user: User
    init(view: ProfileView, user: User) {
        self.view = view
        self.user = user
    }

    func updateUserProfileView() {
        guard let currentUser = User.currentUser else {return}
        if currentUser.id != self.user.id {
            weak var weakSelf = self
            AlertHelper.showLoading()
            UsersProvider.getOtherUserProfile(userId: self.user.id).on(failed: { error in
                AlertHelper.hideLoading()
            }, completed: {
                AlertHelper.hideLoading()
            }, value: { followingUser in
                weakSelf?.view?.displayUser(user: followingUser)
            }).start()
        } else {
            view?.displayUser(user: currentUser)
        }
    }
}

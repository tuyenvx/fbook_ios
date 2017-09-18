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

    init(view: ProfileView) {
        self.view = view
    }

    func updateUserProfileView() {
        guard let currentUser = User.currentUser else {return}
        view?.displayUser(user: currentUser)
    }
}

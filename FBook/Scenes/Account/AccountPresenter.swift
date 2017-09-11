//
//  AccountPresenter.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol AccountView: class {
    func displayUserInfo(user: User)
}

protocol AccountPresenter {
    func updateUserInfo()
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
}

//
//  AccountPresenter.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/22/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol AccountView: class {
    func refreshAccount()
    func showLoadAccountError(message: String)
}

protocol AccountPresenter {

    func configure(tableView: UITableView)
    func fetchUserInfo()
    func fetchFavoriteCategoriesOfUser()
    func fetchFollowInfo()

}

class AccountPresenterImplementation: NSObject, AccountPresenter {
    fileprivate weak var view: AccountView?
    fileprivate var router: AccountRouter?
    fileprivate var user: User
    var selectedTab: Tab?

    init(view: AccountView?, router: AccountRouter?, user: User) {
        self.view = view
        self.router = router
        self.user = user
    }

    func configure(tableView: UITableView) {
        tableView.registerNibCell(type: HeaderTableViewCell.self)
        tableView.registerNibCell(type: TabTableViewCell.self)
        tableView.registerNibCell(type: CategoryTableViewCell.self)
        tableView.registerNibCell(type: FollowerTableViewCell.self)
        tableView.registerNibCell(type: FollowingTableViewCell.self)
        tableView.registerNibCell(type: ProfileTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self

    }

    func fetchUserInfo() {
        weak var weakSelf = self
        AlertHelper.showLoading()
//        TODO after send userId after comment line when click
        UsersProvider.getOtherUserProfile(userId: 1).on(failed: { error in
            AlertHelper.hideLoading()
        }, completed: {
            AlertHelper.hideLoading()
        }, value: { user in
            weakSelf?.user = user
        }).start()
    }

    func fetchFavoriteCategoriesOfUser() {

    }

    func fetchFollowInfo() {
    }

}

extension AccountPresenterImplementation: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension AccountPresenterImplementation: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 250
        case 1:
            return 50
        case 2:
            return 300
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableNibCell(type: HeaderTableViewCell.self) else {
                return UITableViewCell()
            }
            cell.displayAvatar(user)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableNibCell(type: TabTableViewCell.self) else {
                return UITableViewCell()
            }
            cell.handleButtonProfileTapped = { [weak self] in
                self?.handleButtonProfileTapped()
            }

            cell.handleButtonCategoriesTapped = { [weak self] in
                self?.handleButtonCategoriesTapped()
            }

            cell.handleButtonFollowersTapped = { [weak self] in
                self?.handleButtonFollowersTapped()
            }

            cell.handleButtonFollowingTapped = { [weak self] in
                self?.handleButtonFollowingTapped()
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableNibCell(type: ProfileTableViewCell.self) else {
                return UITableViewCell()
            }
            cell.displayProfile(user)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    fileprivate func handleButtonProfileTapped() {
        
    }

    fileprivate func handleButtonCategoriesTapped() {
        
    }

    fileprivate func handleButtonFollowersTapped() {
        
    }

    fileprivate func handleButtonFollowingTapped() {
        
    }
}

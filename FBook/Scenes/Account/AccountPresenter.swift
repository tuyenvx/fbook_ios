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
    func fetchFollowers()
    func fetchFollowingUsers()
    func handleLoadCategoriesSuccess(_ categories: [Category])
    func handleLoadUsersSuccess(_ users: [User])
    func handleLoadUserInfoSuccess()

}

class AccountPresenterImplementation: NSObject, AccountPresenter {

    fileprivate weak var view: AccountView?
    fileprivate var router: AccountRouter?
    fileprivate var user: User
    var selectedTab: Tab?
    fileprivate var listCategories = [Category]()
    fileprivate var listUsers = [User]()
    fileprivate var currentTab = Tab.profile

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
//        TODO check userID when push navigation
        UsersProvider.getOtherUserProfile(userId: user.id).on(failed: { error in
            Utility.shared.showMessage(message: error.message, completion: nil)
            AlertHelper.hideLoading()
        }, completed: {
            AlertHelper.hideLoading()
        }, value: { user in
            weakSelf?.user = user
            weakSelf?.handleLoadUserInfoSuccess()
        }).start()
    }

    func fetchFavoriteCategoriesOfUser() {
        //        TODO check userID when push navigation
        AlertHelper.showLoading()
        UsersProvider.getFavoriteCategoriesOfCurrentUser(userId: user.id).on(failed: { error in
            Utility.shared.showMessage(message: error.message, completion: nil)
            AlertHelper.hideLoading()
        }, completed: {
            AlertHelper.hideLoading()
        }, value: { categories in
            self.handleLoadCategoriesSuccess(categories)
        }).start()
    }

    func fetchFollowers() {
        //        TODO check userID when push navigation
        AlertHelper.showLoading()
        UsersProvider.getFollowersOfUser(userId: user.id).on(failed: { error in
            Utility.shared.showMessage(message: error.message, completion: nil)
            AlertHelper.hideLoading()
        }, completed: {
            AlertHelper.hideLoading()
        }, value: { users in
            self.handleLoadUsersSuccess(users)
        }).start()
    }

    func fetchFollowingUsers() {
        //        TODO check userID when push navigation
        AlertHelper.showLoading()
        UsersProvider.getFollowingOfUser(userId: user.id).on(failed: { error in
            Utility.shared.showMessage(message: error.message, completion: nil)
            AlertHelper.hideLoading()
        }, completed: {
            AlertHelper.hideLoading()
        }, value: { users in
            self.handleLoadUsersSuccess(users)
        }).start()
    }

    func handleLoadCategoriesSuccess(_ categories: [Category]) {
        listCategories.removeAll()
        listCategories.append(contentsOf: categories)
        self.view?.refreshAccount()
    }

    func handleLoadUsersSuccess(_ users: [User]) {
        listUsers.removeAll()
        listUsers.append(contentsOf: users)
        self.view?.refreshAccount()
    }

    func handleLoadUserInfoSuccess() {
        self.view?.refreshAccount()
    }

}

extension AccountPresenterImplementation: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            switch currentTab {
            case .profile:
                return 1
            case .categories:
                return listCategories.count
            case .following:
                return listUsers.count
            case .followers:
                return listUsers.count
            }
        default:
            return 1
        }
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
            switch currentTab {
            case .profile: return 300
            case .categories: return 50
            case .followers: return 70
            case .following: return 70
            }
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
                self?.currentTab = cell.selectedTab
            }

            cell.handleButtonCategoriesTapped = { [weak self] in
                self?.handleButtonCategoriesTapped()
                self?.currentTab = cell.selectedTab
            }

            cell.handleButtonFollowersTapped = { [weak self] in
                self?.handleButtonFollowersTapped()
                self?.currentTab = cell.selectedTab
            }

            cell.handleButtonFollowingTapped = { [weak self] in
                self?.handleButtonFollowingTapped()
                self?.currentTab = cell.selectedTab
            }
            return cell
        case 2:
            switch currentTab {
            case .profile:
                return loadProfileTab(tableView: tableView)
            case .categories:
                return loadCategoriesTab(tableView: tableView, indexPath: indexPath)
            case .followers:
                return loadFollowersTab(tableView: tableView, indexPath: indexPath)
            case .following:
                return loadFollowingTab(tableView: tableView, indexPath: indexPath)
            }
        default:
            return UITableViewCell()
        }
    }

    fileprivate func handleButtonProfileTapped() {
        fetchUserInfo()
    }

    fileprivate func handleButtonCategoriesTapped() {
        fetchFavoriteCategoriesOfUser()
    }

    fileprivate func handleButtonFollowersTapped() {
        fetchFollowers()
    }

    fileprivate func handleButtonFollowingTapped() {
        fetchFollowingUsers()
    }

    fileprivate func loadProfileTab(tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableNibCell(type: ProfileTableViewCell.self) else {
            return UITableViewCell()
        }
        cell.displayProfile(user)
        return cell
    }

    fileprivate func loadCategoriesTab(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableNibCell(type: CategoryTableViewCell.self) else {
            return UITableViewCell()
        }
        cell.updateCell(categoryName: listCategories[indexPath.row].name)
        return cell
    }

    fileprivate func loadFollowersTab(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableNibCell(type: FollowerTableViewCell.self) else {
            return UITableViewCell()
        }
        cell.updateCell(listUsers[indexPath.row])
        return cell
    }

    fileprivate func loadFollowingTab(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableNibCell(type: FollowingTableViewCell.self) else {
            return UITableViewCell()
        }
        cell.updateCell(listUsers[indexPath.row])
        return cell
    }
}

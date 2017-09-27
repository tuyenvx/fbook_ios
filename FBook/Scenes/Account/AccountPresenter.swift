//
//  AccountPresenter.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/22/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit
import SwiftHEXColors
import RxSwift
import RxCocoa

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
    func updateFollow()
    func handleLoadCategoriesSuccess(_ categories: [Category])
    func handleLoadUsersSuccess(_ users: [User])
    func handleLoadUserInfoSuccess()

}

class AccountPresenterImplementation: NSObject, AccountPresenter {

    fileprivate weak var view: AccountView?
    fileprivate var router: AccountRouter?
    fileprivate var user: User
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
        guard let currentUser = User.currentUser else {
            return
        }
        weak var weakSelf = self
        if currentUser.id != self.user.id {
            AlertHelper.showLoading()
            UsersProvider.getOtherUserProfile(userId: self.user.id).on(failed: { error in
                Utility.shared.showMessage(message: error.message, completion: nil)
            }, disposed: {
                AlertHelper.hideLoading()
            }, value: { userInfo in
                weakSelf?.user = userInfo
                weakSelf?.handleLoadUserInfoSuccess()
            }).start()
        } else {
            weakSelf?.handleLoadUserInfoSuccess()
        }
    }

    func fetchFavoriteCategoriesOfUser() {
        guard let currentUser = User.currentUser else {
            return
        }
        if currentUser.id != self.user.id {
            AlertHelper.showLoading()
            UsersProvider.getFavoriteCategoriesOfCurrentUser(userId: user.id).on(failed: { error in
                Utility.shared.showMessage(message: error.message, completion: nil)
            }, disposed: {
                AlertHelper.hideLoading()
            }, value: { categories in
                self.handleLoadCategoriesSuccess(categories)
            }).start()
        } else {
            self.handleLoadCategoriesSuccess(currentUser.favoriteCategories)
        }
    }

    func fetchFollowers() {
        AlertHelper.showLoading()
        UsersProvider.getFollowersOfUser(userId: user.id).on(failed: { error in
            Utility.shared.showMessage(message: error.message, completion: nil)
        }, disposed: {
            AlertHelper.hideLoading()
        }, value: { users in
            self.handleLoadUsersSuccess(users)
        }).start()
    }

    func fetchFollowingUsers() {
        AlertHelper.showLoading()
        UsersProvider.getFollowingOfUser(userId: user.id).on(failed: { error in
            Utility.shared.showMessage(message: error.message, completion: nil)
        }, disposed: {
            AlertHelper.hideLoading()
        }, value: { users in
            self.handleLoadUsersSuccess(users)
        }).start()
    }

    func updateFollow() {
        AlertHelper.showLoading()
        UsersProvider.followUser(userId: user.id).on(failed: { error in
            Utility.shared.showMessage(message: error.message, completion: nil)
        }, disposed: {
            AlertHelper.hideLoading()
        }, value: { status in
//          TODO Show message when follow/unfollow success(has not key "description" with status code: 200)
            Utility.shared.showMessage(message: "\(status)", completion: nil)
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
            return 270
        case 1:
            return 50
        case 2:
            switch self.currentTab {
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
            cell.setBackgroundCell()
            cell.displayUser(user)
            cell.handleButtonFollowTapped = { _ in
                self.handleButtonFollowTapped(cell: cell)
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableNibCell(type: TabTableViewCell.self) else {
                return UITableViewCell()
            }
            cell.handleButtonTapped = { tab in
                self.handleButtonTapped(tab)
            }
            return cell
        case 2:
            switch self.currentTab {
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            switch currentTab {
            case .categories:
                handleCategoriesCellItemTapped(indexPath: indexPath)
            case .followers:
                handleFollowersCellItemTapped(indexPath: indexPath)
            case .following:
                handleFollowingCellItemTapped(indexPath: indexPath)
            case .profile:
                break
            }
        default:
            break
        }
    }

    fileprivate func handleButtonTapped(_ selectedTab: Tab) {
        self.currentTab = selectedTab
        switch selectedTab {
        case .profile:
            fetchUserInfo()
        case .categories:
            fetchFavoriteCategoriesOfUser()
        case .followers:
            fetchFollowers()
        case .following:
            fetchFollowingUsers()
        }
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

    fileprivate func handleButtonFollowTapped(cell: HeaderTableViewCell) {
        if cell.followButton.isSelected {
            cell.followButtonEnable()
        } else {
            cell.unfollowButtonEnable()
        }
        self.updateFollow()
    }

    fileprivate func handleCategoriesCellItemTapped(indexPath: IndexPath) {
//      TODO handle tap to item in list categories
    }

    fileprivate func handleFollowersCellItemTapped(indexPath: IndexPath) {
        router?.showUserDetail(listUsers[indexPath.row])
    }

    fileprivate func handleFollowingCellItemTapped(indexPath: IndexPath) {
        router?.showUserDetail(listUsers[indexPath.row])
    }
}

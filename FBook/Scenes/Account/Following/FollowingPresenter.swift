//
//  FollowingPresenter.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol FollowingView: class {
    func showLoadFollowingError(message: String)
}

protocol FollowingPresenter {
    func getListFollowingUser(tableView: UITableView)
    func showFollowingUserInfo(tableView: UITableView)
    var router: FollowingRouter { get }
}

class FollowingPresenterImplementation: NSObject, FollowingPresenter {
    fileprivate weak var view: FollowingView?
    internal var router: FollowingRouter
    fileprivate var listFollowing = [User]()
    fileprivate weak var accountViewController: AccountViewController?
    fileprivate var user: User
    let disposeBag = DisposeBag()

    init(view: FollowingView, router: FollowingRouter, user: User) {
        self.view = view
        self.router = router
        self.user = user
    }

    fileprivate func handleLoadFollowingUserError(_ error: Error) {
        view?.showLoadFollowingError(message: error.message)
    }

    func getListFollowingUser(tableView: UITableView) {
        weak var weakSelf = self
        AlertHelper.showLoading()
        UsersProvider.getFollowingOfUser(userId: user.id).on(failed: { error in
            AlertHelper.hideLoading()
            weakSelf?.handleLoadFollowingUserError(error)
        }, completed: {
            AlertHelper.hideLoading()
        }, value: { listUsers in
            Observable.just(listUsers)
                .bind(to: tableView.rx.items(cellIdentifier: "followingCell",
                                             cellType: FollowingTableViewCell.self)) { (index, user, cell) in
                                                cell.updateCell(user: user)
                }
                .disposed(by: self.disposeBag)
        }).start()
    }

    func showFollowingUserInfo(tableView: UITableView) {
        tableView.rx.modelSelected(User.self)
            .subscribe(onNext: { user in
                self.router.showFollowingUserInfo(user)
            })
            .disposed(by: self.disposeBag)
    }
}

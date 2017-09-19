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
}

class FollowingPresenterImplementation: NSObject {
    fileprivate weak var view: FollowingView?
    fileprivate var listFollowing = [User]()
    let disposeBag = DisposeBag()

    init(view: FollowingView) {
        self.view = view
    }

    fileprivate func handleLoadFollowingUserError(_ error: Error) {
        view?.showLoadFollowingError(message: error.message)
    }
}

extension FollowingPresenterImplementation: FollowingPresenter {

    func getListFollowingUser(tableView: UITableView) {
        weak var weakSelf = self
        AlertHelper.showLoading()
        UsersProvider.getFollowingOfUser(userId: 1).on(failed: { error in
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
}

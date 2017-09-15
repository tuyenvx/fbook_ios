//
//  NotificationPresenter.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

protocol NotificationView: class {
    func refreshNotification()
    func showLoadNotificationError(message: String)
}

protocol NotificationPresenter {
    func configure(tableView: UITableView)
    func getListNotifications()
}

class NotificationPresenterImplementation: NSObject {

    fileprivate weak var view: NotificationView?
    fileprivate var listNotification = [NotificationDetail]()

    init(view: NotificationView) {
        self.view = view
    }

    fileprivate func handleLoadNotificationError(_ error: Error) {
        view?.showLoadNotificationError(message: error.message)
    }

    fileprivate func handleLoadNotificationSuccess(_ listNotification: [NotificationDetail]) {
        self.listNotification.removeAll()
        self.listNotification.append(contentsOf: listNotification)
        view?.refreshNotification()
    }
}

extension NotificationPresenterImplementation: NotificationPresenter {
    func configure(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func getListNotifications() {
        weak var weakSelf = self
        AlertHelper.showLoading()
        UsersProvider.getListNotifications().on(failed: { error in
            AlertHelper.hideLoading()
            weakSelf?.handleLoadNotificationError(error)
        }, completed: {
            AlertHelper.hideLoading()
        }, value: { notifications in
            weakSelf?.handleLoadNotificationSuccess(notifications)
        }).start()
    }

}

extension NotificationPresenterImplementation: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension NotificationPresenterImplementation: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return listNotification.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notificationDetail = self.listNotification[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell")
            as? NotificationTableViewCell else {return UITableViewCell()}
            cell.updateCell(notification: notificationDetail)
        return cell
    }
}

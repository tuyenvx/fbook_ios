//
//  BaseViewRouter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/12/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

protocol BaseViewRouter {
    func showMenuSetting(delegate: MenuSettingPresenterDelegate, senderFrame: CGRect)
    func showWorkspace()
    func showFeedback()
    func showMoreTools()
}

struct BaseViewRouterImplementation {

    fileprivate weak var view: BaseViewController?

    init(view: BaseViewController?) {
        self.view = view
    }

    @discardableResult fileprivate func openSafariViewController(urlString: String) -> Bool {
        guard let url = URL(string: urlString) else {
            return false
        }
        let safariViewController = FBSafariViewController(url: url)
        view?.present(safariViewController, animated: true, completion: nil)
        return true
    }

}

extension BaseViewRouterImplementation: BaseViewRouter {

    func showMenuSetting(delegate: MenuSettingPresenterDelegate, senderFrame: CGRect) {
        let menu = MenuSettingViewController(nibName: "MenuSettingViewController", bundle: nil)
        menu.modalPresentationStyle = .overFullScreen
        let configurator = MenuConfiguratorImplementation(delegate: delegate, senderFrame: senderFrame)
        menu.configurator = configurator
        view?.present(menu, animated: false, completion: nil)
    }

    func showWorkspace() {
        let workspace = ChooseWorkspaceViewController(nibName: "ChooseWorkspaceViewController", bundle: nil)
        workspace.configurator = ChooseWorkspaceConfiguratorImplementation(delegate: nil)
        workspace.modalPresentationStyle = .overFullScreen
        view?.present(workspace, animated: false, completion: nil)
    }

    func showFeedback() {
        openSafariViewController(urlString: kFeedbackURL)
    }

    func showMoreTools() {
        openSafariViewController(urlString: kMoreToolsURL)
    }

}

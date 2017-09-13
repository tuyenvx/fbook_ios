//
//  BaseViewRouter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/12/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol BaseViewRouter {
    func showMenuSetting(delegate: MenuSettingPresenterDelegate, senderFrame: CGRect)
    func showWorkspace()
    func back()
    func showFeedback()
    func showMoreTools()
}

struct BaseViewRouterImplementation {

    fileprivate weak var view: BaseViewController?

    init(view: BaseViewController?) {
        self.view = view
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
        // TODO: show work space
    }

    func back() {
        _ = view?.navigationController?.popViewController(animated: true)
    }

    func showFeedback() {
        // TODO: show feedback
    }

    func showMoreTools() {
        // TODO: show more tools
    }

}

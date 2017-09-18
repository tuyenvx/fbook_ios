//
//  BaseViewPresenter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/12/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol BaseView: class {
}

protocol BasePresenter {
    func menuButtonTapped(senderFrame: CGRect)
    func backButtonTapped()
}

class BasePresenterImplementation {

    fileprivate weak var view: BaseView?
    fileprivate let router: BaseViewRouter?

    init(view: BaseView?, router: BaseViewRouter?) {
        self.view = view
        self.router = router
    }

}

extension BasePresenterImplementation: BasePresenter {

    func menuButtonTapped(senderFrame: CGRect) {
        router?.showMenuSetting(delegate: self, senderFrame: senderFrame)
    }

    func backButtonTapped() {
        router?.back()
    }

}

extension BasePresenterImplementation: MenuSettingPresenterDelegate {

    func didSelectFeedback() {
        router?.showFeedback()
    }

    func didSelectMoreTools() {
        router?.showMoreTools()
    }

    func didSelectWorkspace() {
        router?.showWorkspace()
    }

}

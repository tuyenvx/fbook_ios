//
//  WaitingRequestPresenter.swift
//  FBook
//
//  Created by Huy Pham on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol WaitingRequestView: class {
}

protocol WaitingRequestPresenter {
}

class WaitingRequestPresenterImplementation {

    fileprivate weak var view: WaitingRequestView!
    fileprivate var router: WaitingRequestViewRouter

    init(view: WaitingRequestView, router: WaitingRequestViewRouter) {
        self.view = view
        self.router = router
    }
}

extension WaitingRequestPresenterImplementation: WaitingRequestPresenter {
}

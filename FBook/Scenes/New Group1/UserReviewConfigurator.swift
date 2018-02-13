//
//  UserReviewConfigurator.swift
//  FBook
//
//  Created by TuyenVX on 2/13/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation

protocol UserReviewConfigurator {
    func config(view: UserReviewViewController)
}

struct UserReviewConfiguratorImplement: UserReviewConfigurator {
    var reviews: [Review]?

    init(reviews: [Review]?) {
        self.reviews = reviews
    }

    func config(view: UserReviewViewController) {
        let presenter = UserReviewPresenterImplement(view: view, reviews: reviews)
        view.presenter = presenter
    }
}

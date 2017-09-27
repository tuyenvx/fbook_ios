//
//  TabTableViewCell.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/22/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

enum Tab {
    case profile
    case categories
    case followers
    case following
}

class TabTableViewCell: UITableViewCell {

    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var categoriesButton: UIButton!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!

    var handleButtonProfileTapped: () -> Void = { }
    var handleButtonCategoriesTapped: () -> Void = { }
    var handleButtonFollowersTapped: () -> Void = { }
    var handleButtonFollowingTapped: () -> Void = { }

    var selectedTab: ((Tab) -> Void)?

    @IBAction func onButtonProfileTapped(_ sender: Any) {
        updateButtonView(tab: .profile)
        handleButtonProfileTapped()
    }

    @IBAction func onButtonCategoriesTapped(_ sender: Any) {
        updateButtonView(tab: .categories)
        handleButtonCategoriesTapped()
    }

    @IBAction func onButtonFollowersTapped(_ sender: Any) {
        updateButtonView(tab: .followers)
        handleButtonFollowersTapped()
    }

    @IBAction func onButtonFollowingTapped(_ sender: Any) {
        updateButtonView(tab: .following)
        handleButtonFollowingTapped()
    }

    func updateButtonView(tab: Tab) {
        [profileButton, categoriesButton, followersButton, followingButton].forEach { button in
            button?.isSelected = false
        }
        switch tab {
        case .profile:
             profileButton.isSelected = true
        case .categories:
            categoriesButton.isSelected = true
        case .followers:
            followersButton.isSelected = true
        case .following:
            followingButton.isSelected = true
        }
    }
}

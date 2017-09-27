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

    var handleButtonTapped: (Tab) -> Void = { _ in }

    var selectedTab = Tab.profile

    @IBAction func onButtonProfileTapped(_ sender: Any) {
        updateButtonView(tab: .profile)
        handleButtonTapped(.profile)
    }

    @IBAction func onButtonCategoriesTapped(_ sender: Any) {
        updateButtonView(tab: .categories)
        handleButtonTapped(.categories)
    }

    @IBAction func onButtonFollowersTapped(_ sender: Any) {
        updateButtonView(tab: .followers)
        handleButtonTapped(.followers)
    }

    @IBAction func onButtonFollowingTapped(_ sender: Any) {
        updateButtonView(tab: .following)
        handleButtonTapped(.following)
    }

    func updateButtonView(tab: Tab) {
        [profileButton, categoriesButton, followersButton, followingButton].forEach { button in
            button?.isSelected = false
        }
        switch tab {
        case .profile:
            profileButton.isSelected = true
            selectedTab = .profile
        case .categories:
            categoriesButton.isSelected = true
            selectedTab = .categories
        case .followers:
            followersButton.isSelected = true
            selectedTab = .followers
        case .following:
            followingButton.isSelected = true
            selectedTab = .following
        }
    }
}

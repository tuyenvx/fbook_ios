//
//  HomeHeaderViewCell.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class HomeHeader: UIView {

    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var seemoreButton: UIButton!
    @IBOutlet weak var moreIconImageView: UIImageView!

    var presenter: HomeHeaderPresenter?
    var configurator: HomeHeaderConfigurator?
    fileprivate weak var delegate: HomeHeaderViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction fileprivate func seeMoreButtonTapped(_ sender: Any) {
        presenter?.didSelectSeeMore()
    }

}

extension HomeHeader: HomeHeaderView {

    func displayConfigurator(_ configurator: HomeHeaderConfigurator) {
        self.configurator = configurator
        self.configurator?.configure(view: self)
    }

    func displayTitle(_ title: String) {
        titleLabel.text = title
    }

    func sholdShowMoreButton(_ isHidden: Bool) {
        seemoreButton.isHidden = isHidden
        moreIconImageView.isHidden = isHidden
    }

}

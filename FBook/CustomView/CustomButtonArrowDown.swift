//
//  CustomButtonArrowDown.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 10/2/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class CustomButtonArrowDown: UIButton {

    fileprivate let arrowDownImageView = UIImageView()
    fileprivate let sizeArrow: CGFloat = 17.0
    fileprivate let margin: CGFloat = 6.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

    func initView() {
        arrowDownImageView.image = #imageLiteral(resourceName: "icon_arrow_down")
        addSubview(arrowDownImageView)
        layer.cornerRadius = 3.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
        clipsToBounds = true
        contentHorizontalAlignment = .left
        titleEdgeInsets = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: sizeArrow + margin)
        setTitleColor(.lightGray, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 13)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let originArrow = CGPoint(x: frame.size.width - sizeArrow - margin, y: (frame.size.height - sizeArrow) / 2)
        arrowDownImageView.frame = CGRect(origin: originArrow, size: CGSize(width: sizeArrow, height: sizeArrow))
    }

}

//
//  GradientCollectionReusableView.swift
//  FBook
//
//  Created by admin on 5/29/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class GradientCollectionReusableView: UICollectionReusableView {
    
    var gradientLayer = CAGradientLayer()
    let height : CGFloat = 30.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gradientLayer.frame = CGRect(x: 0, y: frame.height-height, width: frame.width, height: height)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.locations = [0.0 as NSNumber, 0.75 as NSNumber]
        gradientLayer.colors = [UIColor.white.cgColor, UIColor(netHex: 0xC8C8C8).withAlphaComponent(0.8).cgColor]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = CGRect(x: 0, y: frame.height-height, width: frame.width, height: height)
    }
}

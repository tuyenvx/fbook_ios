//
//  AccountViewController.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import SwiftHEXColors
import RxSwift
import RxCocoa

class AccountViewController: BaseViewController {

    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var headerAccountView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        userAvatarImage.layer.zPosition = 1
    }

    func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.headerAccountView.bounds
        gradientLayer.colors = [UIColor(hexString: "#F23031")?.cgColor as Any,
                                UIColor(hexString: "#FF6A3B")?.cgColor as Any]
        self.headerAccountView.layer.addSublayer(gradientLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

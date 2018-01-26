//
//  StartViewController.swift
//  FBook
//
//  Created by TuyenVX on 1/26/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    var isLogin: Bool {
        get{
            if Token.access_token != nil {
                return true
            } else {
                return false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideLoading()
        if isLogin {
            mainTabbarController?.gotoHome()
        } else {
            gotoLogin()
        }
    }
    func gotoLogin() {
        let loginVC = LoginViewController.fromStoryboard(.login)
        present(loginVC, animated: true, completion: nil)
    }
}

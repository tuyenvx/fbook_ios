//
//  LoginPresenter.swift
//  FBook
//
//  Created by TuyenVX on 1/26/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol LoginView: class {
    func startLoading()
    func finishLoading()
    func gotoHome()
    func showError(error: Error)
}

protocol LoginPresenster {
    func login(_ email: String, _ password: String)
}

class LoginPresensterImplementation: LoginPresenster {
    
    var view: LoginView
    init(view: LoginView) {
        self.view = view
    }
    
    func login(_ email: String, _ password: String) {
        view.startLoading()
        let input = DoLoginInput(email, password)
        let apiService = DoLoginApiService()
        apiService.doLogin(input) { [weak self] (output, error) in
            self?.view.finishLoading()
            if let output = output {
                Token.initWith(output.fAuth)
                self?.view.gotoHome()
            }
            if let error = error {
                self?.view.showError(error: error)
            }
        }
    }

}

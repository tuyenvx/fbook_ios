//
//  LoginViewController.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class LoginViewController: BaseViewController {

    @IBOutlet fileprivate weak var emailTextField: UITextField?
    @IBOutlet fileprivate weak var passwordTextField: UITextField?
    @IBOutlet fileprivate weak var loginButton: UIButton?

    var loginPresenter: LoginPresenter?
    var loginConfigurator = LoginConfiguratorImplementation()
    fileprivate let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        loginConfigurator.configure(loginViewController: self)
        updateUI()
        addObserverUpdateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        application.statusBarStyle = .default
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        application.statusBarStyle = .lightContent
    }

    fileprivate func updateUI() {
        for textField in [emailTextField, passwordTextField] {
            textField?.layer.borderColor = UIColor.red.cgColor
            textField?.layer.borderWidth = 1.0
            textField?.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 0.0, 0.0)
        }
    }

    fileprivate func addObserverUpdateUI() {
        guard let emailObserver = emailTextField?.rx.text.asObservable(),
                let passwordObserver = passwordTextField?.rx.text.asObservable(), let loginButton = loginButton else {
            fatalError("@IBOutlet error")
        }
        Observable.combineLatest(emailObserver, passwordObserver, resultSelector: { (email, password) in
            return (email?.isValidEmail() == true) && (password?.isEmpty == false)
        }).bind(to: loginButton.rx.isEnabled).addDisposableTo(disposeBag)
    }

    @IBAction fileprivate func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField?.text, let password = passwordTextField?.text else {
            return
        }
        loginPresenter?.login(email: email, password: password)
    }

    @IBAction fileprivate func forgotPasswordButtonTapped(_ sender: Any) {
        loginPresenter?.didSelectForgotPassword()
    }

    @IBAction fileprivate func closeButtonTapped(_ sender: Any) {
        loginPresenter?.didSelectClose()
    }

}

extension LoginViewController: LoginView {

    func endEditing() {
        view.endEditing(true)
    }

    func showLoginSuccessful() {
        loginPresenter?.openTabBarController()
    }

    func showLoginError(message: String) {
        Utility.shared.showMessage(inViewController: self, message: message, completion: nil)
    }

}

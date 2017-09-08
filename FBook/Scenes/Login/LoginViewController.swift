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

    fileprivate var loginPresenter: LoginPresenter?
    fileprivate let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        loginPresenter = LoginPresenter(view: self)
        updateUI()
        addObserverUpdateUI()
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
        view.endEditing(true)
        SVProgressHUD.show()
        loginPresenter?.login(email: email, password: password)
    }

    @IBAction fileprivate func forgotPasswordButtonTapped(_ sender: Any) {
        // TODO: show forgot password screen
    }

    @IBAction fileprivate func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension LoginViewController: LoginView {

    func showLoginResult(user: User?, error: Error?) {
        SVProgressHUD.dismiss()
        if let error = error {
            Utility.shared.showMessage(inViewController: self, message: error.message, completion: nil)
        } else if user != nil {
            // TODO show tabBar screen
        }
    }

}

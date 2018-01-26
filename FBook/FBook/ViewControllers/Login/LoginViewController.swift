//
//  LoginViewController.swift
//  FBook
//
//  Created by admin on 5/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var configurator = LoginConfituratorImplementation()
    var presenter: LoginPresenster!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(loginViewController: self)
    }
    
    @IBAction func onTapCancel(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        mainTabbarController?.gotoHome()
    }

    @IBAction func onTapLogin(sender: AnyObject) {
        if let email = emailTextField.text, let pass = passTextField.text {
            if email.isEmpty {
                self.showAlert(message: AppStrings.AlertMessage.emailEmpty.rawValue, andTitle: AppStrings.AlertTitle.error.rawValue)
            }
            else if pass.isEmpty {
                self.showAlert(message: AppStrings.AlertMessage.passEmpty.rawValue
                    , andTitle: AppStrings.AlertTitle.error.rawValue)
            }
            else {
                login(email, pass)
            }
        }
    }
    func login(_ email: String, _ password: String) {
        presenter.login(email, password)
    }
}

extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension LoginViewController: LoginView {
    func startLoading() {
        showLoading()
    }
    
    func finishLoading() {
        hideLoading()
    }
    
    func gotoHome() {
        mainTabbarController?.gotoHome()
    }
    
    func showError(error: Error) {
        showError(error: error)
    }
    
    
}

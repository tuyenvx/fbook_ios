//
//  LoginViewController.swift
//  FBook
//
//  Created by admin on 5/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.white.cgColor
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
                
            }
        }
    }
}

extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

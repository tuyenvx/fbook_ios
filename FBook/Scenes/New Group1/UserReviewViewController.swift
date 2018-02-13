//
//  UserReviewViewController.swift
//  FBook
//
//  Created by TuyenVX on 2/8/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class UserReviewViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var starView: CosmosView!
    @IBOutlet weak var reViewTextField: UITextField!
    var presenter: UserReviewPresenter?
    var configurator: UserReviewConfigurator?
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.config(view: self)
        presenter?.addObserver()
        reViewTextField.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyBoardNotifi()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyBoardNotifi()
    }
    func config(configurator: UserReviewConfigurator?) {
        self.configurator = configurator
    }
    @IBAction func sendReview(_ sender: Any) {
    }
    // Keyboard
    func addKeyBoardNotifi() {
        NotificationCenter.default.addObserver( self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver( self, selector: #selector(keyBoardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func removeKeyBoardNotifi() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            UIView.transition(with: view, duration: 2.5, options: .allowAnimatedContent, animations: {
                self.viewBottomConstraint.constant = keyboardHeight
            }, completion: nil)
        }
    }
    @objc func keyBoardWillHide(_ notification: NSNotification) {
        UIView.transition(with: view, duration: 2.5, options: .allowAnimatedContent, animations: {
            self.viewBottomConstraint.constant = 0
        }, completion: nil)
    }
}

extension UserReviewViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension UserReviewViewController: UserReviewView {

}

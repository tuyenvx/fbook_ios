//
//  ProfileViewController.swift
//  FBook
//
//  Created by admin on 5/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    enum RowProfile: Int {
        case rowMyBookshare = 0, rowMyWaitingBook, rowMyReadingBook, rowMyReadBook, rowLogout, rowCount
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.height/2
        self.avatarImage.layer.borderWidth = 1
        self.avatarImage.layer.borderColor = AppColors.tintColor.cgColor
    }

}

extension ProfileViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RowProfile.rowCount.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemProfileCell", for: indexPath)
        switch indexPath.row {
        case RowProfile.rowMyBookshare.rawValue:
            cell.textLabel?.text = AppStrings.ProfileViewController.myBookshare.rawValue
            break
        case RowProfile.rowMyWaitingBook.rawValue:
            cell.textLabel?.text = AppStrings.ProfileViewController.myWaitingBook.rawValue
            break
        case RowProfile.rowMyReadingBook.rawValue:
            cell.textLabel?.text = AppStrings.ProfileViewController.myReadingBook.rawValue
            break
        case RowProfile.rowMyReadBook.rawValue:
            cell.textLabel?.text = AppStrings.ProfileViewController.myReadBook.rawValue
            break
        case RowProfile.rowLogout.rawValue:
            cell.textLabel?.text = AppStrings.ProfileViewController.logout.rawValue
            break
        default: break
            
        }
        
        return cell
    }
}

extension ProfileViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

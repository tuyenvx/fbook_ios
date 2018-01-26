//
//  TabBarController.swift
//  FBook
//
//  Created by admin on 5/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    

    enum TabBarIndex: Int {
        case TAB_HOME = 0, TAB_USER
    }
    
    override func awakeFromNib() {
        gotoStartView()
    }
    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.delegate = self
//        self.setTabBarItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    // MARK:- Setup
    func gotoStartView() {
        let startViewController = StartViewController.fromStoryboard(.main)
        viewControllers = [startViewController]
        hideTabbar(hide: true)
    }
    func gotoHome() {
        dismiss(animated: true, completion: nil)
        guard let homeNavigationCtl = StoryboardID.home.getStoryboard().instantiateInitialViewController() else { return }
        guard let profileNavigationCtl = StoryboardID.profile.getStoryboard().instantiateInitialViewController() else { return  }
        viewControllers = [homeNavigationCtl, profileNavigationCtl]
        selectedIndex = 0
        setTabBarItem()
        hideTabbar(hide: false)
    }
    func gotoLogin() {
        let loginVC = LoginViewController.fromStoryboard(.login)
        present(loginVC, animated: true, completion: nil)
    }
    func hideTabbar(hide: Bool?, animated: Bool = false) {
        self.tabBar.isHidden = hide ?? false
    }
    private func setTabBarItem() {
        
        let tintColor = AppColors.tintColor
//        let normalColor = AppConfig.Color.normalColor
        
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = AppColors.barTintColor
        self.tabBar.tintColor = tintColor
        
        if let items = self.tabBar.items {
            
            let inset = UIEdgeInsetsMake(5, 0, -5, 0)
            
//            let unselectedItem = [NSForegroundColorAttributeName: normalColor]
//            let selectedItem = [NSForegroundColorAttributeName: tintColor]
            
            for (index, item) in items.enumerated() {

//                item.setTitleTextAttributes(unselectedItem, for: .normal)
//                item.setTitleTextAttributes(selectedItem, for: .selected)
                
                item.imageInsets = inset
                
                switch index {
                case TabBarIndex.TAB_HOME.rawValue:
                    item.image = #imageLiteral(resourceName: "tabbar_icon_book").withRenderingMode(.alwaysOriginal)
                    item.selectedImage = #imageLiteral(resourceName: "tabbar_icon_book")
                    break
                case TabBarIndex.TAB_USER.rawValue:
                    item.image = #imageLiteral(resourceName: "tabbar_icon_user").withRenderingMode(.alwaysOriginal)
                    item.selectedImage = #imageLiteral(resourceName: "tabbar_icon_user")
                    break
                default:
                    break
                }
            }
        }
    }
    
    func showLogin() {
        if let vc = UIStoryboard(name: AppStoryboards.storyboardLogin, bundle: nil).instantiateInitialViewController() {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStoryboards.segueIdentifierShowListBook {
            if let vc = segue.destination as? ListBooksViewController {
                if let sort = AppConfig.filter.sort {
                    vc.listBooksType = ListBooksViewController.ListBooksType.section(key: sort.key, title: sort.title)
                }
            }
        }
        else if segue.identifier == AppStoryboards.segueIdentifierShowBookDetail {
            if let vc = segue.destination as? BookDetailViewController {
                if let book = sender as? Book {
                    vc.book = book
                }
            }
        }
    }

}

extension TabBarController : UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if tabBarController.viewControllers?.index(of: viewController) == TabBarIndex.TAB_USER.rawValue {
//            if isLogin == false {
//                isLogin = true
//                self.showLogin()
//                return false
//            }
//            else {
//                return true
//            }
//
//        }
//        return true
//    }
}

//  MainTabBarController.swift
//  ChineseApp

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTab()
    }

    func setupTab() {
        let categoryViewController = CategoryViewController()
      categoryViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed,tag: 0)
        let nv = UINavigationController(rootViewController: categoryViewController)
        
        let myTableViewController = SettingViewController()
        myTableViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        let nv2 = UINavigationController(rootViewController: myTableViewController)
        
              setViewControllers([nv, nv2], animated: false)
    
    }

}

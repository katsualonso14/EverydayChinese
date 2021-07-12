//  MainTabBarController.swift
//  ChineseApp

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTab()
    }

    func setupTab() {
        let CategoryViewController = categoryViewController()
      CategoryViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed,tag: 0)
        
        let myTableViewController = MyTableViewController()
        myTableViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        viewControllers = [CategoryViewController,myTableViewController]
        
    }

}

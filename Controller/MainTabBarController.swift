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
        
        let myTableViewController = MyTableViewController()
        myTableViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        
        viewControllers = [categoryViewController,myTableViewController]
        
    }

}

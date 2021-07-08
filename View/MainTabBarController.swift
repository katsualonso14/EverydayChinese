//  MainTabBarController.swift
//  ChineseApp

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTab()
    }

    func setupTab() {
        let viewController = MyTableViewController()
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed,tag: 0)
        
        let secondViewController = SecondViewController()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        viewControllers = [viewController,secondViewController]
        
    }

}

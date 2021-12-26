//  MainTabBarController.swift
//  ChineseApp

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTab()
    }
    //タブバーの表示
    func setupTab() {
        let categoryViewController = CategoryViewController()
        categoryViewController.tabBarItem.image = UIImage(named: "tag")
        categoryViewController.tabBarItem.title = "Word&Sentence"
        let nv = UINavigationController(rootViewController: categoryViewController)
        
        let myTableViewController = CalendarViewController()
        myTableViewController.tabBarItem.image = UIImage(named: "calendar")
        myTableViewController.tabBarItem.title = "Calendar"
        let nv2 = UINavigationController(rootViewController: myTableViewController)
        
              setViewControllers([nv, nv2], animated: false)
    
    }

}

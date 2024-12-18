//  MainTabBarController.swift
//  ChineseApp

import UIKit
import GoogleMobileAds

class MainTabBarController: UITabBarController, GADBannerViewDelegate {
    
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()

        // Admob広告設定
        let viewWidth = view.frame.inset(by: view.safeAreaInsets).width
        let adaptiveSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        bannerView = GADBannerView(adSize: adaptiveSize)
        
        addBannerViewToView(bannerView)
        bannerView.delegate = self
        
        bannerView.adUnitID = "ca-app-pub-5743090122530738/3794682492" // new admob id
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    //タブバーの表示
    func setupTab() {
        self.tabBar.tintColor = UIColor.systemRed //タブバー選択時の色指定

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
    
    //MARK: -Admob
    func addBannerViewToView(_ bannerView: GADBannerView) {
            bannerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(bannerView)
        
        let tabBarHeight = self.tabBar.frame.size.height
        
            view.addConstraints(
              [NSLayoutConstraint(item: bannerView,
                                  attribute: .bottom,
                                  relatedBy: .equal,
                                  toItem: view.safeAreaLayoutGuide,
                                  attribute: .bottom,
                                  multiplier: 1,
                                  constant: -tabBarHeight),
              NSLayoutConstraint(item: bannerView,
                                  attribute: .centerX,
                                  relatedBy: .equal,
                                  toItem: view,
                                  attribute: .centerX,
                                  multiplier: 1,
                                  constant: 0)
              ])
          }

}

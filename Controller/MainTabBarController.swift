//  MainTabBarController.swift
//  ChineseApp

import UIKit
import GoogleMobileAds

class MainTabBarController: UITabBarController, BannerViewDelegate, FullScreenContentDelegate {
    
    var bannerView: BannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
        checkBanner()
    }
    //MARK: -Layout
    //タブバーの表示
    func setupTab() {
        self.tabBar.tintColor = UIColor.systemRed //タブバー選択時の色指定
        view.backgroundColor = .systemGray6
        
        let phrasesVC = QuickMemoViewController()
        phrasesVC.tabBarItem.image = UIImage(systemName: "pencil.and.scribble")
        phrasesVC.tabBarItem.title = "Quick Memo"
        let nv1 = UINavigationController(rootViewController: phrasesVC)
        
        let phraseStoreVC = PhraseStoreViewController()
        let pencilLine = UIImage(systemName: "pencil.and.outline")
        phraseStoreVC.tabBarItem.image = pencilLine
        phraseStoreVC.tabBarItem.title = "PhraseStore"
        let nv2 = UINavigationController(rootViewController: phraseStoreVC)
        
        let categoryViewController = CategoryViewController()
        categoryViewController.tabBarItem.image = UIImage(named: "tag")
        categoryViewController.tabBarItem.title = "Word&Sentence"
        let nv3 = UINavigationController(rootViewController: categoryViewController)
        
        let calendarVC = CalendarViewController()
        calendarVC.tabBarItem.image = UIImage(systemName: "calendar")
        calendarVC.tabBarItem.title = "Calendar"
        let nv4 = UINavigationController(rootViewController: calendarVC)
        
        setViewControllers([nv1, nv2, nv3, nv4], animated: false)
    }
    
    //MARK: -Admob
    // バナー広告の表示・非表示を確認
    func checkBanner() {
        if AdManager.shouldShowBannerAds() {
            setupBanner()
        }
    }
    
    func setupBanner() {
        let viewWidth = view.frame.inset(by: view.safeAreaInsets).width
        let adaptiveSize = currentOrientationAnchoredAdaptiveBanner(width: viewWidth)
        bannerView = BannerView(adSize: adaptiveSize)
        
        addBannerViewToView(bannerView)
        bannerView.delegate = self
        bannerView.adUnitID = MyAds.bannerID
        bannerView.rootViewController = self
        bannerView.load(Request())
    }
    
    func addBannerViewToView(_ bannerView: BannerView) {
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

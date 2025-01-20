//  MainTabBarController.swift
//  ChineseApp

import UIKit
import GoogleMobileAds

class MainTabBarController: UITabBarController, GADBannerViewDelegate, GADFullScreenContentDelegate {
    
    var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
        // Admob広告設定
        let viewWidth = view.frame.inset(by: view.safeAreaInsets).width
        let adaptiveSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        bannerView = GADBannerView(adSize: adaptiveSize)
        
        addBannerViewToView(bannerView)
        bannerView.delegate = self
        bannerView.adUnitID = MyAds.bannerID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        //TODO: 初回のCookie確認後の表示
        setupInterstitial()
        
    }
    //MARK: -Layout
    //タブバーの表示
    func setupTab() {
        self.tabBar.tintColor = UIColor.systemRed //タブバー選択時の色指定
        view.backgroundColor = .systemGray6
        let categoryViewController = CategoryViewController()
        categoryViewController.tabBarItem.image = UIImage(named: "tag")
        categoryViewController.tabBarItem.title = "Word&Sentence"
        let nv = UINavigationController(rootViewController: categoryViewController)
        
        let quickNotesVC = QuickNotesViewController()
        quickNotesVC.tabBarItem.image = UIImage(systemName: "pencil.and.scribble")
        quickNotesVC.tabBarItem.title = "QuickNotes"
        let nv1 = UINavigationController(rootViewController: quickNotesVC)
        
        let myNotesVC = MyNotesViewController()
        let pencilLine = UIImage(systemName: "pencil.and.outline")
        myNotesVC.tabBarItem.image = pencilLine
        myNotesVC.tabBarItem.title = "MyNotes"
        let nv2 = UINavigationController(rootViewController: myNotesVC)
        
        let myTableViewController = CalendarViewController()
        myTableViewController.tabBarItem.image = UIImage(named: "calendar")
        myTableViewController.tabBarItem.title = "Calendar"
        let nv3 = UINavigationController(rootViewController: myTableViewController)
        
        setViewControllers([nv, nv1, nv2, nv3], animated: false)
        

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
    
    // インタースティシャル広告設定
    func setupInterstitial() {
        Task {
            do {
                // 読み込み
                interstitial = try await GADInterstitialAd.load(
                    withAdUnitID: MyAds.interstialAdId, request: GADRequest()
                )
                // Delegate設定
                interstitial?.fullScreenContentDelegate = self
                // 広告の表示
                guard let interstitial = interstitial else {
                    return print("Ad wasn't ready.")
                }
                
                // The UIViewController parameter is an optional.
                interstitial.present(fromRootViewController: nil)
                
            } catch {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                
            }
        }
    }
    
}

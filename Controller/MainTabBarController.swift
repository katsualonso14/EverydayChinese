//  MainTabBarController.swift
//  ChineseApp

import UIKit
import GoogleMobileAds

class MainTabBarController: UITabBarController, GADBannerViewDelegate, GADFullScreenContentDelegate {
    
    var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBanner()
        setupTab()        
        //TODO: 初回のCookie確認後の表示
//        setupInterstitial()
        
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
        
        setViewControllers([nv1, nv2, nv3], animated: false)
    }
    
    //MARK: -Admob
    func setupBanner() {
        let viewWidth = view.frame.inset(by: view.safeAreaInsets).width
        let adaptiveSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        bannerView = GADBannerView(adSize: adaptiveSize)
        
        addBannerViewToView(bannerView)
        bannerView.delegate = self
        bannerView.adUnitID = MyAds.bannerID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
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

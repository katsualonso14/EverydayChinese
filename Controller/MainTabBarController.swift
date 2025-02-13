import UIKit
import GoogleMobileAds
import UserMessagingPlatform

class MainTabBarController: UITabBarController, BannerViewDelegate {
    
    var bannerView: BannerView!
    let requestParameters = UMPRequestParameters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
        // UPM確認後にバナー表示をチェックする
        checkUPM()
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
    
    //MARK: Check Admob UPM
    // Admobのユーロ,イギリス、スイスユーザーに向けてのUPM設定
    func checkUPM() {
        // アプリが起動するたびに呼び出す
        UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: requestParameters) {
            [weak self] requestConsesentError in
            guard let self else { return }
            
            if let error = requestConsesentError {
                print(error.localizedDescription)
            }
            
            UMPConsentForm.loadAndPresentIfRequired(from: self) {
                [weak self] loadAndPresentError in
                guard let self else { return }
                
                if let error = loadAndPresentError {
                    print(error.localizedDescription)
                }
            }
            
            // Consent gathering process has completed
            if UMPConsentInformation.sharedInstance.canRequestAds {
                MobileAds.shared.start()
                checkBanner()
            }
        }
    }
}

import UIKit
import GoogleMobileAds
import UserMessagingPlatform
import AppTrackingTransparency
import AdSupport

class MainTabBarController: UITabBarController, BannerViewDelegate {
    
    var bannerView: BannerView!
    let requestParameters = UMPRequestParameters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // トラッキングチェック・UPM確認後にバナー表示
        requestTrackingPermission()
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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if AdManager.shouldShowBannerAds() {
                self.setupBanner()
            } else {
                self.bannerView?.removeFromSuperview()
            }
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
        
        let tabBarY = self.tabBar.frame.origin.y
        
        NSLayoutConstraint.activate([
            bannerView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: tabBarY),
            bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
                    print("UMP Form Load Error: \(error.localizedDescription)")
                }
                
                print("UMP Form completed, waiting for canRequestAds...")
                waitForCanRequestAds()
            }
        }
    }

    func waitForCanRequestAds() {
        DispatchQueue.global().async {
            while !UMPConsentInformation.sharedInstance.canRequestAds {
                sleep(1) // 1秒ごとにチェック
            }
            
            DispatchQueue.main.async {
                print("canRequestAds is now true. Initializing AdMob...")
                MobileAds.shared.start { status in
                    print("AdMob SDK initialized")
                    self.checkBanner()
                }
            }
        }
    }
    
    // ユーザートラッキングの許可(ATT)を求める
    func requestTrackingPermission() {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                //認証された場合
                print("Tracking authorized")
                self.checkUPM()
            case .denied, .notDetermined, .restricted:
                //認証されなかった場合でも、UPMをチェックして広告表示
                print("Tracking not authorized")
                self.checkUPM()
            @unknown default:
                print("Unknown status")
                self.checkUPM()
            }
        }
    }


}

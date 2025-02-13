import UIKit
import GoogleMobileAds

class AdManager: NSObject, FullScreenContentDelegate {
    static let shared = AdManager()
    var rewardedAd: RewardedAd?
    
    private override init() {
        super.init()
    }

    func setupReword(viewController: UIViewController) async {
        await loadRewardedAd()
        if rewardedAd != nil {
            DispatchQueue.main.async {
                AdManager.shared.show(viewController: viewController)
            }
        } else {
            print("Rewarded ad wasn't ready.")
        }
    }
    
    func show(viewController: UIViewController) {
        guard let rewardedAd = rewardedAd else {
            return print("Ad wasn't ready.")
        }
        
        rewardedAd.present(from: viewController, userDidEarnRewardHandler: {
            let reward = rewardedAd.adReward
            print("Reward received with currency: \(reward.type), amount \(reward.amount).")
            self.disableBannerAdsForOneHour()
        })
        
    }
    
    // リワード広告の読み込み
    func loadRewardedAd() async {
        do {
            rewardedAd = try await RewardedAd.load(
                with: MyAds.rewardAdId,
                request: Request()
            )
            rewardedAd?.fullScreenContentDelegate = self
        } catch {
            print("Rewarded ad failed to load with error: \(error.localizedDescription)")
        }
    }
    
    // バナー広告を24時間非表示
    private func disableBannerAdsForOneHour() {
        let expirationTime = Date().addingTimeInterval(86400)
        UserDefaults.standard.set(expirationTime, forKey: "bannerAdExpiration")
    }
    
    // 現在バナー広告を表示するべきかを判定
    static func shouldShowBannerAds() -> Bool {
        if let expiration = UserDefaults.standard.object(forKey: "bannerAdExpiration") as? Date {
            return expiration < Date() // 現在時刻が保存された時間より後なら表示
        }
        return true // 設定がなければ表示
    }
    
    //MARK: - FullScreenContentDelegate
    // 広告読み込み失敗時の処理設定
    func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad failed to present full screen content with error: \(error.localizedDescription)")
        // 追加のデバッグ情報
        if let nsError = error as? NSError {
            print("Error domain: \(nsError.domain), code: \(nsError.code), description: \(nsError.localizedDescription)")
        }
    }
    
    // 広告が表示される直前に呼ばれる設定
    func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("Ad will present full screen content.")
    }
    
    // 広告が閉じられた後に呼ばれる設定
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        Task {
            //TODO: 広告閉じた際のバナー非表示即時反映
            // 広告を再読み込み
            await loadRewardedAd()
        }
    }
    
}

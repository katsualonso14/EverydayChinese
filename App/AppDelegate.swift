//  AppDelegate.swift
//  ChineseApp
import UIKit
import UserNotifications
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
   //アプリ起動時に呼び出されるメソッド
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Admob Initialize Setting
        MobileAds.shared.start(completionHandler: nil)
        
        //通知許可の取得
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]){
                (granted, _) in
                if granted{
                    UNUserNotificationCenter.current().delegate = self
                } else {
                    print("通知が許可されていない")
                }
            }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    //通知受信時の処理
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
          // アプリ起動中でもアラートと音で通知
          completionHandler([.banner, .sound])
          
      }
      
    //TODO: Greetings以外の通知タップの動き確認,アプリキル時への展開
    //通知をタップした時の処理(起動中)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // 選択されているタブを取得
        if let tabBarController = UIApplication.shared.windows.first?.rootViewController as? UITabBarController {
            if let navController = tabBarController.selectedViewController as? UINavigationController {
                // 受け取った通知のUserInfoを委任
                let checkNotifController = CheckNotifController()
                let userInfo = response.notification.request.content.userInfo
                checkNotifController.navigateToPage(navController: navController, page: userInfo["page"] as! String)
                
            } else {
                // 選択されているタブがUINavigationControllerでない場合、UINavigationControllerを取得
                let navController = UINavigationController()
                let checkNotifController = CheckNotifController()
                let userInfo = response.notification.request.content.userInfo
                checkNotifController.navigateToPage(navController: navController, page: userInfo["page"] as! String)
            }
        }
        
        completionHandler()
    }

    
}


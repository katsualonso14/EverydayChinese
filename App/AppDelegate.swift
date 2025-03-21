//  AppDelegate.swift
//  ChineseApp
import UIKit
import UserNotifications
import GoogleMobileAds
import AppTrackingTransparency
import RealmSwift
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
   //Methoed when the app is launched
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Admob Initialize Setting
        MobileAds.shared.start(completionHandler: nil)
        
        // Request for App Notification
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]){
                (granted, _) in
                if granted{
                    UNUserNotificationCenter.current().delegate = self
                } else {
                    print("通知が許可されていない")
                }
                
                // ATT Request for 1 second delay
                  DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                      self.requestTrackingPermission()
                  }
            }
        
        // Settting for Daily Record Reminder
        scheduleDailyNotification()
        // When the app killed and user tap the notification
              if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
                  handleNotification(userInfo: notification)
              }
        
        //Firebase Setting
        FirebaseApp.configure()
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
      
    // アプリが起動中 or バックグラウンドのときに通知をタップした場合
     func userNotificationCenter(_ center: UNUserNotificationCenter,didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void
     ) {
         let userInfo = response.notification.request.content.userInfo
         handleNotification(userInfo: userInfo)
         completionHandler()
     }
    // 通知をタップした際の処理
    func handleNotification(userInfo: [AnyHashable: Any]) {
        guard let page = userInfo["page"] as? String else { return }
        
        DispatchQueue.main.async {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = scene.windows.first,
               let tabBarController = window.rootViewController as? UITabBarController,
               let navController = tabBarController.selectedViewController as? UINavigationController {
                let checkNotifController = CheckNotifController()
                checkNotifController.navigateToPage(navController: navController, page: page)
            }
        }
    }

    //MARK: - ATT
    func requestTrackingPermission() {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                print("Tracking authorized")
                NotificationCenter.default.post(name: NSNotification.Name("TrackingAuthorized"), object: nil)
            case .denied, .notDetermined, .restricted:
                print("Tracking not authorized")
                NotificationCenter.default.post(name: NSNotification.Name("TrackingNotAuthorized"), object: nil)
            @unknown default:
                print("Unknown status")
                NotificationCenter.default.post(name: NSNotification.Name("TrackingNotAuthorized"), object: nil)
            }
        }
    }

    //MARK: - Notification
    // 連続ログイン日数を取得
    func getConsecutiveLoginDays() -> Int {
        let realm = try! Realm()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        let savedDates = realm.objects(EventModel.self).sorted(byKeyPath: "date", ascending: false).compactMap { event -> Date? in
            return formatter.date(from: event.date)
        }
        
        guard let latestDate = savedDates.first else { return 0 }
        
        var consecutiveDays = 1
        var prevDate = latestDate

        for date in savedDates.dropFirst() {
            // 1日以内にログインしていたら
            if let expectedDate = Calendar.current.date(byAdding: .day, value: -1, to: prevDate),
               Calendar.current.isDate(date, inSameDayAs: expectedDate) {

                consecutiveDays += 1
                prevDate = date
            } else {
                break
            }
        }

        return consecutiveDays
    }
    // 連続ログイン通知設定
    func scheduleDailyNotification() {
        let center = UNUserNotificationCenter.current()
        // 既存の通知を削除
        center.removePendingNotificationRequests(withIdentifiers: ["dailyLoginNotification"])
        
        let content = UNMutableNotificationContent()
        let loginDays = getConsecutiveLoginDays()
        // 2日以内の場合は通知しない
        if(loginDays < 2) {
            return
        }
        
        content.title = "Consecutive Logins"
        content.body = "You have logged in for \(loginDays) days in a row! Keep it up!"
        content.sound = .default
        content.userInfo = ["page": "calendar"] // 通知をタップした際にカレンダーページへ遷移指定
        
        var dateComponents = DateComponents()
        dateComponents.hour = 8
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyLoginNotification", content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("通知のスケジュール設定エラー: \(error)")
            }
        }
    }

    
}


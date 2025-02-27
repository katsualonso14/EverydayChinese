//メインページ
import UIKit

class CategoryViewController: UIViewController {
    
    let greetingVC = GreetingsViewController(titleName: "Greetings")
    let pronounsVC = PronounsViewController(titleName: "Pronouns")
    let dailyVC = DailyTalkViewController(titleName: "Daily conversation")
    let tripVC = TripViewController(titleName: "Trip")
    let restaurantVC = RestaurantViewController(titleName: "Restaurant")
    let dramaVC = DramaViewController(titleName: "Drama")

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Category"
        let scrollView = UIScrollView() // for scroll
        self.view.addSubview(scrollView)
        
        setupDailyButton()
        setupTripAndOutingsButton()
        setupDramaButton()
        setDeleteNotifButton()
    }
    
    // 日常会話ボタン
    func setupDailyButton() {
        let dailyButton:UIButton = UIButton()
        self.view.addSubview(dailyButton)
        dailyButton.translatesAutoresizingMaskIntoConstraints = false
        dailyButton.backgroundColor = .systemBackground
        
        dailyButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        dailyButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dailyButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        dailyButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        dailyButton.layer.cornerRadius = 25.0
        dailyButton.layer.masksToBounds = true
        
        dailyButton.setTitle("Daily Conversation", for: .normal)
        dailyButton.setTitleColor(AppColors.textColor, for: .normal)
        dailyButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        dailyButton.setImage(UIImage(named: "advanced"), for: .normal)
        dailyButton.contentHorizontalAlignment = .left
        dailyButton.imageView?.contentMode = .scaleAspectFit
        dailyButton.imageView?.layer.cornerRadius = 15.0
        dailyButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        dailyButton.addTarget(self, action: #selector(pushDailyButton), for: .touchUpInside)
        
    }
    // 旅行用ボタン
    func setupTripAndOutingsButton() {
        let tripButton:UIButton = UIButton()
        self.view.addSubview(tripButton)
        tripButton.translatesAutoresizingMaskIntoConstraints = false
        tripButton.backgroundColor = .systemBackground
        //connstraitでlayoutを調整する
        tripButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300).isActive = true
        tripButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tripButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        tripButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        tripButton.layer.cornerRadius = 25.0
        tripButton.layer.masksToBounds = true
        
        tripButton.setTitle("Trip&Outings", for: .normal)
        tripButton.setTitleColor(AppColors.textColor, for: .normal)
        tripButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        tripButton.setImage(UIImage(named: "trip"), for: .normal)
        tripButton.contentHorizontalAlignment = .left
        tripButton.imageView?.contentMode = .scaleAspectFit
        tripButton.imageView?.layer.cornerRadius = 15.0
        tripButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        tripButton.addTarget(self, action: #selector(pushTripAndOutingsButton), for: .touchUpInside)
    }
    // ドラマ用ボタン
    func setupDramaButton() {
        let dramaButton:UIButton = UIButton()
        self.view.addSubview(dramaButton)
        dramaButton.translatesAutoresizingMaskIntoConstraints = false
        dramaButton.backgroundColor = .systemBackground
        //connstraitでlayoutを調整する
        dramaButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 450).isActive = true
        dramaButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dramaButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        dramaButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        dramaButton.layer.cornerRadius = 25.0
        dramaButton.layer.masksToBounds = true
        
        dramaButton.setTitle("Drama", for: .normal)
        dramaButton.setTitleColor(AppColors.textColor, for: .normal)
        dramaButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        dramaButton.setImage(UIImage(named: "drama"), for: .normal)
        dramaButton.contentHorizontalAlignment = .left
        dramaButton.imageView?.contentMode = .scaleAspectFit
        dramaButton.imageView?.layer.cornerRadius = 15.0
        dramaButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        dramaButton.addTarget(self, action: #selector(pushDramaButton), for: .touchUpInside)
    }
// MARK: - objc
    @objc func pushDailyButton(sender: UIButton){
        let vc = DailyConverViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushTripAndOutingsButton(sender: UIButton){
        let vc = TripAndOutingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    // ドラマ用ボタン押した時のアクション
    @objc func pushDramaButton(sender: UIButton){
        navigationController?.pushViewController(dramaVC, animated: true)
    }
    // 全てのリマインドを削除
    @objc func openAllNotifDeleteAleart(){
        let alert = UIAlertController(title: "Delete all reminders",
                                      message: "If you tap delete, all reminders will be deleted. Are you sure?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [self] _ in
            deleteAllNotif()
            deleteAllFavorites()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Delete Notification
    func setDeleteNotifButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bell.circle"), for: .normal)
        button.tintColor = AppColors.appMainColor
        button.addTarget(self, action: #selector(openAllNotifDeleteAleart), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
    }
    //全ての通知を削除する処理
    func deleteAllNotif() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
        //全ての通知を削除しましたのダイアログ表示
        let alert = UIAlertController(title: "All notifications removed.", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // 全てのハートボタンの状態を削除
    func deleteAllFavorites() {
        UserDefaults.standard.removeObject(forKey: greetingVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: pronounsVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: dailyVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: tripVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: restaurantVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: dramaVC.favoritesLocalKey)
        
    }
    
    //大きい画像などのメモリ解放
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


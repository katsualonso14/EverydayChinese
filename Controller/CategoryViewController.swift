//メインページ
import UIKit

class CategoryViewController: UIViewController {
    
    let greetingVC = GreetingsViewController(titleName: "Greetings")
    let pronounsVC = PersonalPronounsViewController(titleName: "Pronouns")
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
        setRewordAdButton()
    }
    
    // 日常会話ボタン
    func setupDailyButton() {
        let dailyButton:UIButton = UIButton()
        self.view.addSubview(dailyButton)
        dailyButton.translatesAutoresizingMaskIntoConstraints = false
        dailyButton.backgroundColor = .systemBackground
        dailyButton.layer.cornerRadius = 25.0
        dailyButton.layer.masksToBounds = true
        
        dailyButton.setTitle("Daily Conversation", for: .normal)
        dailyButton.setTitleColor(AppColors.textColor, for: .normal)
        dailyButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        dailyButton.titleLabel?.numberOfLines = 0
        let subTitleLabel = UILabel()
        subTitleLabel.text = "Greetings, DailyTalk, Pronouns"
        subTitleLabel.font = .systemFont(ofSize: 13)
        subTitleLabel.textColor = .systemGray
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        dailyButton.addSubview(subTitleLabel)
        
        dailyButton.setImage(UIImage(named: "conversation_100*100"), for: .normal)
        dailyButton.contentHorizontalAlignment = .left
        dailyButton.imageView?.contentMode = .scaleAspectFit
        dailyButton.imageView?.layer.cornerRadius = 15.0
        dailyButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        dailyButton.addTarget(self, action: #selector(pushDailyButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            dailyButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 130),
            dailyButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            dailyButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            dailyButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.13),
            
            subTitleLabel.topAnchor.constraint(equalTo: dailyButton.titleLabel!.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: dailyButton.titleLabel!.leadingAnchor, constant: 0),
        ])
        
    }
    // 旅行用ボタン
    func setupTripAndOutingsButton() {
        let tripButton:UIButton = UIButton()
        self.view.addSubview(tripButton)
        tripButton.translatesAutoresizingMaskIntoConstraints = false
        tripButton.backgroundColor = .systemBackground
        tripButton.layer.cornerRadius = 25.0
        tripButton.layer.masksToBounds = true
        
        tripButton.setTitle("Trip&Outings", for: .normal)
        tripButton.setTitleColor(AppColors.textColor, for: .normal)
        tripButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        let subTitleLabel = UILabel()
        subTitleLabel.text = "Trip, Restaurant"
        subTitleLabel.font = .systemFont(ofSize: 13)
        subTitleLabel.textColor = .systemGray
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tripButton.addSubview(subTitleLabel)
        
        tripButton.setImage(UIImage(named: "trip_100*100"), for: .normal)
        tripButton.contentHorizontalAlignment = .left
        tripButton.imageView?.contentMode = .scaleAspectFit
        tripButton.imageView?.layer.cornerRadius = 15.0
        tripButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        tripButton.addTarget(self, action: #selector(pushTripAndOutingsButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            tripButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 280),
            tripButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tripButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            tripButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.13),
            
            subTitleLabel.topAnchor.constraint(equalTo: tripButton.titleLabel!.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: tripButton.titleLabel!.leadingAnchor, constant: 0),
        ])
    }
    // ドラマ用ボタン
    func setupDramaButton() {
        let dramaButton:UIButton = UIButton()
        self.view.addSubview(dramaButton)
        dramaButton.translatesAutoresizingMaskIntoConstraints = false
        dramaButton.backgroundColor = .systemBackground
        dramaButton.layer.cornerRadius = 25.0
        dramaButton.layer.masksToBounds = true
        
        dramaButton.setTitle("Drama", for: .normal)
        dramaButton.setTitleColor(AppColors.textColor, for: .normal)
        dramaButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        let subTitleLabel = UILabel()
        subTitleLabel.text = "Drama"
        subTitleLabel.font = .systemFont(ofSize: 13)
        subTitleLabel.textColor = .systemGray
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        dramaButton.addSubview(subTitleLabel)
        
        dramaButton.setImage(UIImage(named: "drama_100*100"), for: .normal)
        dramaButton.contentHorizontalAlignment = .left
        dramaButton.imageView?.contentMode = .scaleAspectFit
        dramaButton.imageView?.layer.cornerRadius = 15.0
        dramaButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        dramaButton.addTarget(self, action: #selector(pushDramaButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            dramaButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 430),
            dramaButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            dramaButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            dramaButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.13),
            
            subTitleLabel.topAnchor.constraint(equalTo: dramaButton.titleLabel!.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: dramaButton.titleLabel!.leadingAnchor, constant: 0),
        ])
    }
    
    func setDeleteNotifButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bell.circle"), for: .normal)
        button.tintColor = AppColors.appMainColor
        button.addTarget(self, action: #selector(openAllNotifDeleteAleart), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    func setRewordAdButton() {
        let button = UIBarButtonItem(title: "Ads Hide Settings", style: .plain, target: self, action: #selector(showRewardAlert))
        button.tintColor = AppColors.appMainColor
        navigationItem.rightBarButtonItem = button
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
    
    @objc func showRewardAlert() {
        let alert = UIAlertController(
            title: "Delete Ads for 24 hours",
            message: "If you watch the reward ad, the ad at the bottom of the screen will be hidden for 24 hours.\nWould you like to see it?",
            preferredStyle: .alert
            )

        let watchAction = UIAlertAction(title: "Watch", style: .default) { _ in
            self.getReword()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(watchAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }

    //MARK - Delete Notification
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
    //MARK: - Reward Ads
    func getReword() {
        Task {
            await AdManager.shared.setupReword(viewController: self)
        }
    }
    //大きい画像などのメモリ解放
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


//メインページ
import UIKit

class CategoryViewController: UIViewController {
    // 各カテゴリのViewControllerをインスタンス化
    let greetingVC = GreetingsViewController(titleName: "Greetings")
    let pronounsVC = PersonalPronounsViewController(titleName: "Pronouns")
    let dailyVC = DailyTalkViewController(titleName: "Daily conversation")
    let tripVC = TripViewController(titleName: "Trip")
    let restaurantVC = RestaurantViewController(titleName: "Restaurant")
    let dramaVC = DramaViewController(titleName: "Drama")
    
    let container = UIView()
    let scrollView = UIScrollView()
    let dailyButton:UIButton = UIButton()
    let greetingButton:UIButton = UIButton()
    let tripButton:UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Category"
        setupScrollView()
        setupContainer()
        // Buttons Setting
        setupDailyButton()
        setupGreetingButton()
        setupTripButton()
        setupDramaButton()
        setDeleteNotifButton()
        setRewordAdButton()
    }
    
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)


        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
        // contentSizeを設定
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 2300)
    }
    
    func setupContainer() {
        container.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: scrollView.topAnchor),
            container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            container.heightAnchor.constraint(equalToConstant: 3000), // 全体の高さを設定
            container.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            
        ])
    }
    
    // 日常会話ボタン
    func setupDailyButton() {
        self.container.addSubview(dailyButton)
        self.view.addSubview(dailyButton)
        dailyButton.translatesAutoresizingMaskIntoConstraints = false
        dailyButton.addTarget(self, action: #selector(pushDailyButton), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = "DailyTalk"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = AppColors.textColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dailyButton.addSubview(titleLabel)
        
        let imageView = UIImageView(image: UIImage(named: "conversation_100*100"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25.0
        imageView.layer.masksToBounds = true
        dailyButton.addSubview(imageView)
    
        
        NSLayoutConstraint.activate([
            // button
            dailyButton.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 30),
            dailyButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
            dailyButton.widthAnchor.constraint(equalTo: self.container.widthAnchor, multiplier: 0.3),
            dailyButton.heightAnchor.constraint(equalTo: self.container.heightAnchor, multiplier: 0.03),
            // title
            titleLabel.topAnchor.constraint(equalTo: dailyButton.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: dailyButton.centerXAnchor),
            // imageView
            imageView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: dailyButton.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: dailyButton.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
        ])
    }
    // 挨拶ボタン
    func setupGreetingButton() {
        self.container.addSubview(greetingButton)
        self.view.addSubview(greetingButton)
        greetingButton.translatesAutoresizingMaskIntoConstraints = false
        greetingButton.addTarget(self, action: #selector(pushGreetingButton), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = "Greeting"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = AppColors.textColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        greetingButton.addSubview(titleLabel)
        
        let imageView = UIImageView(image: UIImage(named: "Greetings"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25.0
        imageView.layer.masksToBounds = true
        greetingButton.addSubview(imageView)
    
        
        NSLayoutConstraint.activate([
            // button
            greetingButton.topAnchor.constraint(equalTo: dailyButton.bottomAnchor, constant: 70),
            greetingButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
            greetingButton.widthAnchor.constraint(equalTo: self.container.widthAnchor, multiplier: 0.3),
            greetingButton.heightAnchor.constraint(equalTo: self.container.heightAnchor, multiplier: 0.03),
            // title
            titleLabel.topAnchor.constraint(equalTo: greetingButton.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: greetingButton.centerXAnchor),
            // imageView
            imageView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: greetingButton.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: greetingButton.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
        ])
    }
    
    // 旅行用ボタン
    func setupTripButton() {
        self.container.addSubview(tripButton)
        self.view.addSubview(tripButton)
        tripButton.translatesAutoresizingMaskIntoConstraints = false
        tripButton.addTarget(self, action: #selector(pushTripButton), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = "Trip"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = AppColors.textColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        tripButton.addSubview(titleLabel)
        
        let imageView = UIImageView(image: UIImage(named: "trip"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25.0
        imageView.layer.masksToBounds = true
        tripButton.addSubview(imageView)
    
        
        NSLayoutConstraint.activate([
            // button
            tripButton.topAnchor.constraint(equalTo: greetingButton.bottomAnchor, constant: 70),
            tripButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
            tripButton.widthAnchor.constraint(equalTo: self.container.widthAnchor, multiplier: 0.3),
            tripButton.heightAnchor.constraint(equalTo: self.container.heightAnchor, multiplier: 0.03),
            // title
            titleLabel.topAnchor.constraint(equalTo: tripButton.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: tripButton.centerXAnchor),
            // imageView
            imageView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: tripButton.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: tripButton.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
        ])
    }
    //TODO: ここから下のUI修正
    // ドラマ用ボタン
    func setupDramaButton() {
        let dramaButton:UIButton = UIButton()
        self.container.addSubview(dramaButton)
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
            dramaButton.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 630),
            dramaButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
            dramaButton.widthAnchor.constraint(equalTo: self.container.widthAnchor, multiplier: 0.8),
            dramaButton.heightAnchor.constraint(equalTo: self.container.heightAnchor, multiplier: 0.06),
            
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
    @objc func pushGreetingButton(sender: UIButton){
        let vc = GreetingsViewController(titleName: "Greeting")
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func pushTripButton(sender: UIButton){
        let vc = TripViewController(titleName: "Trip")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushTripAndOutingsButton(sender: UIButton){
        let vc = TripAndOutingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
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


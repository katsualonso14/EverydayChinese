//メインページ
import UIKit

class CategoryViewController: UIViewController {
    // 各カテゴリのViewControllerをインスタンス化
    let greetingVC = GreetingsViewController(titleName: "Greetings")
    let personalPronounsVC = PersonalPronounsViewController(titleName: "Personal Pronouns")
    let dailyVC = DailyTalkViewController(titleName: "Daily conversation")
    let tripVC = TripViewController(titleName: "Trip")
    let restaurantVC = RestaurantViewController(titleName: "Restaurant")
    let dramaVC = DramaViewController(titleName: "Drama")
    
    let container = UIView()
    let scrollView = UIScrollView()
    let dailyButton:UIButton = UIButton()
    let greetingButton:UIButton = UIButton()
    let tripButton:UIButton = UIButton()
    let restaurantButton:UIButton = UIButton()
    let dramaButton:UIButton = UIButton()
    let personalPronounsButton:UIButton = UIButton()
    let demonstrativePronounsButton:UIButton = UIButton()
    let interrogativePronounsButton:UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Category"
        setupScrollView()
        setupContainer()
        // Buttons Setting
        setupDailyButton()
        setupGreetingButton()
        setupTripButton()
        setupRestaurantButton()
        setupDramaButton()
        setupPersonalPronounsButton()
        setupDemonstrativePronounsButton()
        setupInterrogativePronounsButton()
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
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 2400)
    }
    
    func setupContainer() {
        container.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: scrollView.topAnchor),
            container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            container.heightAnchor.constraint(equalToConstant: 2400), // 全体の高さを設定
            container.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            
        ])
    }
    
    // 日常会話ボタン
    func setupDailyButton() {
        self.container.addSubview(dailyButton)
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
            dailyButton.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 50),
            dailyButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
            dailyButton.widthAnchor.constraint(equalTo: self.container.widthAnchor, multiplier: 0.25),
            dailyButton.heightAnchor.constraint(equalTo: dailyButton.widthAnchor),
            // title
            titleLabel.bottomAnchor.constraint(equalTo: dailyButton.topAnchor, constant: -7),
            titleLabel.centerXAnchor.constraint(equalTo: dailyButton.centerXAnchor),
            // imageView
            imageView.topAnchor.constraint(equalTo: dailyButton.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: dailyButton.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: dailyButton.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: dailyButton.heightAnchor),
        ])
    }
    // 挨拶ボタン
    func setupGreetingButton() {
        self.container.addSubview(greetingButton)
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
            greetingButton.topAnchor.constraint(equalTo: dailyButton.bottomAnchor, constant: 50),
            greetingButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
            greetingButton.widthAnchor.constraint(equalTo: self.container.widthAnchor, multiplier: 0.25),
            greetingButton.heightAnchor.constraint(equalTo: greetingButton.widthAnchor),
            // title
            titleLabel.bottomAnchor.constraint(equalTo: greetingButton.topAnchor, constant: -7),
            titleLabel.centerXAnchor.constraint(equalTo: greetingButton.centerXAnchor),
            // imageView
            imageView.topAnchor.constraint(equalTo: greetingButton.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: greetingButton.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: greetingButton.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: greetingButton.heightAnchor)
        ])
    }
    
    // 旅行用ボタン
    func setupTripButton() {
        self.container.addSubview(tripButton)
        tripButton.translatesAutoresizingMaskIntoConstraints = false
        tripButton.addTarget(self, action: #selector(pushTripButton), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = "Trip"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = AppColors.textColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        tripButton.addSubview(titleLabel)
        
        let imageView = UIImageView(image: UIImage(named: "trip_100*100"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25.0
        imageView.layer.masksToBounds = true
        tripButton.addSubview(imageView)
    
        
        NSLayoutConstraint.activate([
            // button
            tripButton.topAnchor.constraint(equalTo: greetingButton.bottomAnchor, constant: 50),
            tripButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
            tripButton.widthAnchor.constraint(equalTo: self.container.widthAnchor, multiplier: 0.25),
            tripButton.heightAnchor.constraint(equalTo: tripButton.widthAnchor),
            // title
            titleLabel.bottomAnchor.constraint(equalTo: tripButton.topAnchor, constant: -7),
            titleLabel.centerXAnchor.constraint(equalTo: tripButton.centerXAnchor),
            // imageView
            imageView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: tripButton.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: tripButton.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: tripButton.heightAnchor),
        ])
    }
    // レストラン用ボタン
    func setupRestaurantButton() {
        self.container.addSubview(restaurantButton)
        restaurantButton.translatesAutoresizingMaskIntoConstraints = false
        restaurantButton.addTarget(self, action: #selector(pushRestaurantButton), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = "Restaurant"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = AppColors.textColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        restaurantButton.addSubview(titleLabel)
        
        let imageView = UIImageView(image: UIImage(named: "restaurant_100*100"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25.0
        imageView.layer.masksToBounds = true
        restaurantButton.addSubview(imageView)
    
        
        NSLayoutConstraint.activate([
            // button
            restaurantButton.topAnchor.constraint(equalTo: tripButton.bottomAnchor, constant: 50),
            restaurantButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
            restaurantButton.widthAnchor.constraint(equalTo: self.container.widthAnchor, multiplier: 0.25),
            restaurantButton.heightAnchor.constraint(equalTo:restaurantButton.widthAnchor),
            // title
            titleLabel.bottomAnchor.constraint(equalTo: restaurantButton.topAnchor, constant: -7),
            titleLabel.centerXAnchor.constraint(equalTo: restaurantButton.centerXAnchor),
            // imageView
            imageView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: restaurantButton.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: restaurantButton.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: restaurantButton.heightAnchor),
        ])
    }
    // ドラマ用ボタン用
    func setupDramaButton() {
        self.container.addSubview(dramaButton)
        dramaButton.translatesAutoresizingMaskIntoConstraints = false
        dramaButton.addTarget(self, action: #selector(pushDramaButton), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = "Drama"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = AppColors.textColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dramaButton.addSubview(titleLabel)
        
        let imageView = UIImageView(image: UIImage(named: "drama_100*100"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25.0
        imageView.layer.masksToBounds = true
        dramaButton.addSubview(imageView)
    
        
        NSLayoutConstraint.activate([
            // button
            dramaButton.topAnchor.constraint(equalTo: restaurantButton.bottomAnchor, constant: 50),
            dramaButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
            dramaButton.widthAnchor.constraint(equalTo: self.container.widthAnchor, multiplier: 0.25),
            dramaButton.heightAnchor.constraint(equalTo: dramaButton.widthAnchor),
            // title
            titleLabel.topAnchor.constraint(equalTo: dramaButton.topAnchor, constant: -7),
            titleLabel.centerXAnchor.constraint(equalTo: dramaButton.centerXAnchor),
            // imageView
            imageView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: dramaButton.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: dramaButton.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: dramaButton.heightAnchor)
        ])
    }
    // 人物名詞ボタン
    func setupPersonalPronounsButton() {
        self.container.addSubview(personalPronounsButton)
        personalPronounsButton.translatesAutoresizingMaskIntoConstraints = false
        personalPronounsButton.addTarget(self, action: #selector(pushPersonalPronounsButton), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = "Personal"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = AppColors.textColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        personalPronounsButton.addSubview(titleLabel)
        
        let imageView = UIImageView(image: UIImage(named: "Personal Pronouns"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25.0
        imageView.layer.masksToBounds = true
        personalPronounsButton.addSubview(imageView)
    
        
        NSLayoutConstraint.activate([
            // button
            personalPronounsButton.topAnchor.constraint(equalTo: dramaButton.bottomAnchor, constant: 50),
            personalPronounsButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor, constant: -90),
            personalPronounsButton.widthAnchor.constraint(equalTo: self.container.widthAnchor, multiplier: 0.25),
            personalPronounsButton.heightAnchor.constraint(equalTo: personalPronounsButton.widthAnchor),
            // title
            titleLabel.topAnchor.constraint(equalTo: personalPronounsButton.topAnchor, constant: -7),
            titleLabel.centerXAnchor.constraint(equalTo: personalPronounsButton.centerXAnchor),
            // imageView
            imageView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: personalPronounsButton.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: personalPronounsButton.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: personalPronounsButton.heightAnchor)
        ])
    }
    // 名詞ボタン(これ・それ）
    func setupDemonstrativePronounsButton() {
        self.container.addSubview(demonstrativePronounsButton)
        demonstrativePronounsButton.translatesAutoresizingMaskIntoConstraints = false
        demonstrativePronounsButton.addTarget(self, action: #selector(pushDemonstrativePronounsButton), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = "Demonstartive"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = AppColors.textColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        demonstrativePronounsButton.addSubview(titleLabel)
        
        let imageView = UIImageView(image: UIImage(named: "Demonstrative Pronouns"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25.0
        imageView.layer.masksToBounds = true
        demonstrativePronounsButton.addSubview(imageView)
    
        
        NSLayoutConstraint.activate([
            // button
            demonstrativePronounsButton.topAnchor.constraint(equalTo: dramaButton.bottomAnchor, constant: 50),
            demonstrativePronounsButton.centerXAnchor.constraint(equalTo: personalPronounsButton.trailingAnchor, constant: 140),
            demonstrativePronounsButton.widthAnchor.constraint(equalTo: self.container.widthAnchor, multiplier: 0.25),
            demonstrativePronounsButton.heightAnchor.constraint(equalTo: demonstrativePronounsButton.widthAnchor),
            // title
            titleLabel.topAnchor.constraint(equalTo: demonstrativePronounsButton.topAnchor, constant: -7),
            titleLabel.centerXAnchor.constraint(equalTo: demonstrativePronounsButton.centerXAnchor),
            // imageView
            imageView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: demonstrativePronounsButton.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: demonstrativePronounsButton.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: demonstrativePronounsButton.heightAnchor)
        ])
    }
    //
    func setupInterrogativePronounsButton() {
        self.container.addSubview(interrogativePronounsButton)
        interrogativePronounsButton.translatesAutoresizingMaskIntoConstraints = false
        interrogativePronounsButton.addTarget(self, action: #selector(pushInterrogativePronounsButton), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = "Interrogative"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = AppColors.textColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        interrogativePronounsButton.addSubview(titleLabel)
        
        let imageView = UIImageView(image: UIImage(named: "Interrogative Pronouns"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25.0
        imageView.layer.masksToBounds = true
        interrogativePronounsButton.addSubview(imageView)
    
        
        NSLayoutConstraint.activate([
            // button
            interrogativePronounsButton.topAnchor.constraint(equalTo: demonstrativePronounsButton.bottomAnchor, constant: 50),
            interrogativePronounsButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
            interrogativePronounsButton.widthAnchor.constraint(equalTo: self.container.widthAnchor, multiplier: 0.25),
            interrogativePronounsButton.heightAnchor.constraint(equalTo: dramaButton.widthAnchor),
            // title
            titleLabel.topAnchor.constraint(equalTo: interrogativePronounsButton.topAnchor, constant: -7),
            titleLabel.centerXAnchor.constraint(equalTo: interrogativePronounsButton.centerXAnchor),
            // imageView
            imageView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: interrogativePronounsButton.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: interrogativePronounsButton.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: interrogativePronounsButton.heightAnchor)
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
        let vc = DailyTalkViewController(titleName: "Daily conversation")
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
    @objc func pushRestaurantButton(sender: UIButton){
        print("restaurant tap")
        let vc = RestaurantViewController(titleName: "Restaurant")
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func pushDramaButton(sender: UIButton){
        navigationController?.pushViewController(dramaVC, animated: true)
    }
    @objc func pushPersonalPronounsButton(sender: UIButton){
        navigationController?.pushViewController(personalPronounsVC, animated: true)
    }
    @objc func pushDemonstrativePronounsButton(sender: UIButton) {
        let vc = DemonstrativePronounsViewController(titleName: "Demonstrative Pronouns")
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func pushInterrogativePronounsButton(sender: UIButton) {
        let vc = InterrogativePronounsViewController(titleName: "Interrogative Pronouns")
        navigationController?.pushViewController(vc, animated: true)
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
        UserDefaults.standard.removeObject(forKey: personalPronounsVC.favoritesLocalKey)
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


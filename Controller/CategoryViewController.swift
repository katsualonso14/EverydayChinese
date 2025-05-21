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
    let shoppingVC = ShoppingViewController(titleName: "Shopping")
    let phoneVC = PhoneViewController(titleName: "Phone")
    let weatherVC = WeatherViewController(titleName: "Weather")
    let healthVC = HealthViewController(titleName: "Health")
    let businessVC = BusinessViewController(titleName: "Business")
    
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
    let shoppingButton:UIButton = UIButton()
    let phoneButton:UIButton = UIButton()
    let weatherButton:UIButton = UIButton()
    let healthButton:UIButton = UIButton()
    let businessButton:UIButton = UIButton()
    let sentenceList = SentenseList()

    let vocabButtons: [VocabButtonInfo] = [
        VocabButtonInfo(titleKey: "vocab_daily_button_title", imageName: "bubble.left.and.bubble.right", selector: #selector(pushDailyButton)),
        VocabButtonInfo(titleKey: "vocab_greeting_button_title", imageName: "hand.wave", selector: #selector(pushGreetingButton)),
        VocabButtonInfo(titleKey: "vocab_trip_button_title", imageName: "airplane", selector: #selector(pushTripButton)),
        VocabButtonInfo(titleKey: "vocab_restaurant_button_title", imageName: "fork.knife", selector: #selector(pushRestaurantButton)),
        VocabButtonInfo(titleKey: "vocab_drama_button_title", imageName: "film", selector: #selector(pushDramaButton)),
        VocabButtonInfo(titleKey: "vocab_personal_pronouns_button_title", imageName: "person.2", selector: #selector(pushPersonalPronounsButton)),
        VocabButtonInfo(titleKey: "vocab_demonstrative_pronouns_button_title", imageName: "point.topleft.down.curvedto.point.bottomright.up", selector: #selector(pushDemonstrativePronounsButton)),
        VocabButtonInfo(titleKey: "vocab_interrogative_pronouns_button_title", imageName: "questionmark.circle", selector: #selector(pushInterrogativePronounsButton)),
        VocabButtonInfo(titleKey: "vocab_shopping_button_title", imageName: "bag", selector: #selector(pushShoppingButton)),
        VocabButtonInfo(titleKey: "vocab_phone_button_title", imageName: "phone", selector: #selector(pushPhoneButton)),
        VocabButtonInfo(titleKey: "vocab_weather_button_title", imageName: "cloud.sun", selector: #selector(pushWeatherButton)),
        VocabButtonInfo(titleKey: "vocab_health_button_title", imageName: "cross.case", selector: #selector(pushHealthButton)),
        VocabButtonInfo(titleKey: "vocab_business_button_title", imageName: "briefcase", selector: #selector(pushBusinessButton))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("category_title", comment: "")
        setupScrollView()
        setupContainer()
        setupVocabButtons()
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
    // MARK: - Vocab Buttons Setting
    //TODO: カード形式にUI変更後の微調整
    func createVocabItemView(
        titleKey: String,
        imageName: String,
        topAnchor: NSLayoutYAxisAnchor,
        topConstant: CGFloat,
        selector: Selector
    ) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)

        let imageView = createImageView()
        view.addSubview(imageView)
        
        let titleLabel = createLabel(titleKey: titleKey)
        view.addSubview(titleLabel)
        
        let chevronButton = craeteChevronButton()
        view.addSubview(chevronButton)

        let tapGesture = UITapGestureRecognizer(target: self, action: selector)
        view.addGestureRecognizer(tapGesture)
        chevronButton.addTarget(self, action: selector, for: .touchUpInside)

        // レイアウト
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: topConstant),
            view.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            view.widthAnchor.constraint(equalTo: view.superview!.widthAnchor, multiplier: 0.9),
            view.heightAnchor.constraint(equalToConstant: 110),

            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),

            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            chevronButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            chevronButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            chevronButton.widthAnchor.constraint(equalToConstant: 30),
        ])

        imageView.image = UIImage(systemName: imageName)
        imageView.tintColor = .label

        // ボタンの背景色と角丸
        view.backgroundColor = AppColors.backgroundColorCheckMode
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1 // 薄めで自然な影
        view.layer.shadowOffset = CGSize(width: 0, height: 2) // 下方向に落ちる影
        view.layer.shadowRadius = 4

        return view
    }

    // 各ボタン配置
    func setupVocabButtons() {
        var previousAnchor: NSLayoutYAxisAnchor = container.topAnchor
        var topPadding: CGFloat = view.frame.height * 0.05

        for buttonInfo in vocabButtons {
            let button = createVocabItemView(
                titleKey: buttonInfo.titleKey,
                imageName: buttonInfo.imageName,
                topAnchor: previousAnchor,
                topConstant: topPadding,
                selector: buttonInfo.selector
            )
            previousAnchor = button.bottomAnchor
            topPadding = 15 // 2個目以降は等間隔に
        }
    }
    // 共通のimageViewセットアップ
    func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func createLabel(titleKey: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = NSLocalizedString(titleKey, comment: "")
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        return titleLabel
    }
    
    func craeteChevronButton() -> UIButton {
        let chevronButton = UIButton(type: .system)
        chevronButton.translatesAutoresizingMaskIntoConstraints = false
        chevronButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        chevronButton.tintColor = AppColors.appMainColor
        return chevronButton
    }
    
    // Mark: - AppBar Buttons
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
        let vc = DailyTalkViewController(titleName: NSLocalizedString("vocab_daily_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushGreetingButton(sender: UIButton){
        let vc = GreetingsViewController(titleName: NSLocalizedString("vocab_greeting_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushTripButton(sender: UIButton){
        let vc = TripViewController(titleName: NSLocalizedString("vocab_trip_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushRestaurantButton(sender: UIButton){
        let vc = RestaurantViewController(titleName: NSLocalizedString("vocab_restaurant_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushDramaButton(sender: UIButton){
        let vc = DramaViewController(titleName: NSLocalizedString("vocab_drama_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushPersonalPronounsButton(sender: UIButton){
        let vc = PersonalPronounsViewController(titleName: NSLocalizedString("vocab_personal_pronouns_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushDemonstrativePronounsButton(sender: UIButton) {
        let vc = DemonstrativePronounsViewController(titleName: NSLocalizedString("vocab_demonstrative_pronouns_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushInterrogativePronounsButton(sender: UIButton) {
        let vc = InterrogativePronounsViewController(titleName: NSLocalizedString("vocab_interrogative_pronouns_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushShoppingButton(sender: UIButton) {
        let vc = ShoppingViewController(titleName: NSLocalizedString("vocab_shopping_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushPhoneButton(sender: UIButton) {
        let vc = PhoneViewController(titleName: NSLocalizedString("vocab_phone_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushWeatherButton(sender: UIButton) {
        let vc = WeatherViewController(titleName: NSLocalizedString("vocab_weather_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushHealthButton(sender: UIButton) {
        let vc = HealthViewController(titleName: NSLocalizedString("vocab_health_button_title", comment: ""))
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pushBusinessButton(sender: UIButton) {
        let vc = BusinessViewController(titleName: NSLocalizedString("vocab_business_button_title", comment: ""))
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
            deleteAllRemindList()
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
        UserDefaults.standard.removeObject(forKey: shoppingVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: phoneVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: weatherVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: healthVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: businessVC.favoritesLocalKey)
        
    }
    
    // RemidListから全データ削除
    func deleteAllRemindList() {
        let dataToDelete = ["sentence": sentenceList.sentence[0]]
        NotificationCenter.default.post(name: Notification.Name("deleteRemind"), object: nil, userInfo: dataToDelete)
        
        //ローカルからの削除
        if var savedRemindData = UserDefaults.standard.stringArray(forKey: "remind") {
            savedRemindData.removeAll()
            UserDefaults.standard.set(savedRemindData, forKey: "remind")
        } else {
            print("No data to delete")
        }
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


//メインページ
import UIKit

class CategoryViewController: UIViewController {
    
    let greetingVC = GreetingsViewController(titleName: "Greetings")
    let pronounsVC = PronounsViewController(titleName: "Pronouns")
    let dailyVC = DailyConversationViewController(titleName: "Daily conversation")
    let tripVC = TripViewController(titleName: "Trip")
    let restaurantVC = RestaurantViewController(titleName: "Restaurant")
    let dramaVC = DramaViewController(titleName: "Drama")

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Category"
        let scrollView = UIScrollView() // for scroll
        self.view.addSubview(scrollView)
        //    初心者ボタン
        let button:UIButton = UIButton()
        self.view.addSubview(button)
        //Autosizingのレイアウトの仕組みをAuto Layoutに変換するかどうかを設定するフラグを既存がオンなのでfalse(オフ)に設定
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        //set layout
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: view.frame.height * 0.13).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        button.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        button.layer.cornerRadius = 25.0
        button.layer.masksToBounds = true
        
        button.setTitle("Greetings", for: .normal)
        button.setTitleColor(AppColors.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)

        button.setImage(UIImage(named: "beginner"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.layer.cornerRadius = 15.0
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(pushBignnerButton), for: .touchUpInside)
        //    中級者ボタン
        let intermediateButton:UIButton = UIButton()
        self.view.addSubview(intermediateButton)
        intermediateButton.translatesAutoresizingMaskIntoConstraints = false
        intermediateButton.backgroundColor = .systemBackground
        
        intermediateButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 13).isActive = true
        intermediateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        intermediateButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        intermediateButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        intermediateButton.layer.cornerRadius = 25.0
        intermediateButton.layer.masksToBounds = true
        
        intermediateButton.setTitle("Pronouns", for: .normal)
        intermediateButton.setTitleColor(AppColors.textColor, for: .normal)
        intermediateButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        intermediateButton.setImage(UIImage(named: "intermediate"), for: .normal)
        intermediateButton.contentHorizontalAlignment = .left
        intermediateButton.imageView?.contentMode = .scaleAspectFit
        intermediateButton.imageView?.layer.cornerRadius = 15.0
        intermediateButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        intermediateButton.addTarget(self, action: #selector(pushIntermediateButton), for: .touchUpInside)
        //    上級者ボタン
        let advancedButton:UIButton = UIButton()
        self.view.addSubview(advancedButton)
        advancedButton.translatesAutoresizingMaskIntoConstraints = false
        advancedButton.backgroundColor = .systemBackground
        
        advancedButton.topAnchor.constraint(equalTo: intermediateButton.bottomAnchor, constant: 13).isActive = true
        advancedButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        advancedButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        advancedButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        advancedButton.layer.cornerRadius = 25.0
        advancedButton.layer.masksToBounds = true
        
        advancedButton.setTitle("Daily Talk", for: .normal)
        advancedButton.setTitleColor(AppColors.textColor, for: .normal)
        advancedButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        advancedButton.setImage(UIImage(named: "advanced"), for: .normal)
        advancedButton.contentHorizontalAlignment = .left
        advancedButton.imageView?.contentMode = .scaleAspectFit
        advancedButton.imageView?.layer.cornerRadius = 15.0
        advancedButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        advancedButton.addTarget(self, action: #selector(pushAdvancedButton), for: .touchUpInside)
        // レストラン用ボタン
        let restaurantButton:UIButton = UIButton()
        self.view.addSubview(restaurantButton)
        restaurantButton.translatesAutoresizingMaskIntoConstraints = false
        restaurantButton.backgroundColor = .systemBackground
        //connstraitでlayoutを調整する
        restaurantButton.topAnchor.constraint(equalTo: advancedButton.bottomAnchor, constant: 13).isActive = true
        restaurantButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        restaurantButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        restaurantButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        restaurantButton.layer.cornerRadius = 25.0
        restaurantButton.layer.masksToBounds = true
        
        restaurantButton.setTitle("Restaurant", for: .normal)
        restaurantButton.setTitleColor(AppColors.textColor, for: .normal)
        restaurantButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        restaurantButton.setImage(UIImage(named: "restaurant"), for: .normal)
        restaurantButton.contentHorizontalAlignment = .left
        restaurantButton.imageView?.contentMode = .scaleAspectFit
        restaurantButton.imageView?.layer.cornerRadius = 15.0
        restaurantButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        restaurantButton.addTarget(self, action: #selector(pushRestaurantButton), for: .touchUpInside)
        // 旅行用ボタン
        let tripButton:UIButton = UIButton()
        self.view.addSubview(tripButton)
        tripButton.translatesAutoresizingMaskIntoConstraints = false
        tripButton.backgroundColor = .systemBackground
        //connstraitでlayoutを調整する
        tripButton.topAnchor.constraint(equalTo: restaurantButton.bottomAnchor, constant: 13).isActive = true
        tripButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tripButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        tripButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        tripButton.layer.cornerRadius = 25.0
        tripButton.layer.masksToBounds = true
        
        tripButton.setTitle("Trip", for: .normal)
        tripButton.setTitleColor(AppColors.textColor, for: .normal)
        tripButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        tripButton.setImage(UIImage(named: "trip"), for: .normal)
        tripButton.contentHorizontalAlignment = .left
        tripButton.imageView?.contentMode = .scaleAspectFit
        tripButton.imageView?.layer.cornerRadius = 15.0
        tripButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        tripButton.addTarget(self, action: #selector(pushTripButton), for: .touchUpInside)
        // ドラマ用ボタン
        let dramaButton:UIButton = UIButton()
        self.view.addSubview(dramaButton)
        dramaButton.translatesAutoresizingMaskIntoConstraints = false
        dramaButton.backgroundColor = .systemBackground
        //connstraitでlayoutを調整する
        dramaButton.topAnchor.constraint(equalTo: tripButton.bottomAnchor, constant: 13).isActive = true
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
        
        setDeleteNotifButton()
    }
    
    func setDeleteNotifButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bell.circle"), for: .normal)
        button.tintColor = AppColors.appMainColor
        button.addTarget(self, action: #selector(openAllNotifDeleteAleart), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
    }
    
//    初心者ボタン押した時のアクション
    @objc func pushBignnerButton(sender: UIButton){
        let vc = GreetingsViewController(titleName: "Greetings")
        navigationController?.pushViewController(vc, animated: true)
    }
    //    中級者ボタン押した時のアクション
    @objc func pushIntermediateButton(sender: UIButton){
        let vc = PronounsViewController(titleName: "Pronouns")
        navigationController?.pushViewController(vc, animated: true)
    }
    //    上級者ボタン押した時のアクション
    @objc func pushAdvancedButton(sender: UIButton){
        let vc = DailyConversationViewController(titleName: "Daily conversation")
        navigationController?.pushViewController(vc, animated: true)   }
    
    //    旅行用ボタン押した時のアクション
    @objc func pushTripButton(sender: UIButton){
        let vc = TripViewController(titleName: "Trip")
        navigationController?.pushViewController(vc, animated: true)   }
    //    レストラン用ボタン押した時のアクション
    @objc func pushRestaurantButton(sender: UIButton){
        let vc = RestaurantViewController(titleName: "Restaurant")
        navigationController?.pushViewController(vc, animated: true)   }
    // ドラマ用ボタン押した時のアクション
    @objc func pushDramaButton(sender: UIButton){
        let vc = DramaViewController(titleName: "Drama")
        navigationController?.pushViewController(vc, animated: true)   }
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


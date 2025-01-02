//メインページ
import UIKit

class CategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Category"
        
        //    初心者ボタン
        let button:UIButton = UIButton()
        self.view.addSubview(button)
        //Autosizingのレイアウトの仕組みをAuto Layoutに変換するかどうかを設定するフラグを既存がオンなのでfalse(オフ)に設定
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray6
        //set layout
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        button.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        button.layer.cornerRadius = 25.0
        button.layer.masksToBounds = true
        
        button.setTitle("Beginner", for: .normal)
        button.setTitleColor(.white, for: .normal)
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
        intermediateButton.backgroundColor = .systemGray6
        
        intermediateButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20).isActive = true
        intermediateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        intermediateButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        intermediateButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        intermediateButton.layer.cornerRadius = 25.0
        intermediateButton.layer.masksToBounds = true
        
        intermediateButton.setTitle("Intermediate", for: .normal)
        intermediateButton.setTitleColor(.white, for: .normal)
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
        advancedButton.backgroundColor = .systemGray6
        
        advancedButton.topAnchor.constraint(equalTo: intermediateButton.bottomAnchor, constant: 20).isActive = true
        advancedButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        advancedButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        advancedButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        advancedButton.layer.cornerRadius = 25.0
        advancedButton.layer.masksToBounds = true
        
        advancedButton.setTitle("Advanced", for: .normal)
        advancedButton.setTitleColor(.white, for: .normal)
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
        restaurantButton.backgroundColor = .systemGray6
        //connstraitでlayoutを調整する
        restaurantButton.topAnchor.constraint(equalTo: advancedButton.bottomAnchor, constant: 20).isActive = true
        restaurantButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        restaurantButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        restaurantButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        restaurantButton.layer.cornerRadius = 25.0
        restaurantButton.layer.masksToBounds = true
        
        restaurantButton.setTitle("Restaurant", for: .normal)
        restaurantButton.setTitleColor(.white, for: .normal)
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
        tripButton.backgroundColor = .systemGray6
        //connstraitでlayoutを調整する
        tripButton.topAnchor.constraint(equalTo: restaurantButton.bottomAnchor, constant: 20).isActive = true
        tripButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tripButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        tripButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        tripButton.layer.cornerRadius = 25.0
        tripButton.layer.masksToBounds = true
        
        tripButton.setTitle("Trip", for: .normal)
        tripButton.setTitleColor(.white, for: .normal)
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
        dramaButton.backgroundColor = .systemGray6
        //connstraitでlayoutを調整する
        dramaButton.topAnchor.constraint(equalTo: tripButton.bottomAnchor, constant: 20).isActive = true
        dramaButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dramaButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        dramaButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        dramaButton.layer.cornerRadius = 25.0
        dramaButton.layer.masksToBounds = true
        
        dramaButton.setTitle("Drama", for: .normal)
        dramaButton.setTitleColor(.white, for: .normal)
        dramaButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        dramaButton.setImage(UIImage(named: "drama"), for: .normal)
        dramaButton.contentHorizontalAlignment = .left
        dramaButton.imageView?.contentMode = .scaleAspectFit
        dramaButton.imageView?.layer.cornerRadius = 15.0
        dramaButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        dramaButton.addTarget(self, action: #selector(pushDramaButton), for: .touchUpInside)
        //Learnlig Sentence
    }
//    初心者ボタン押した時のアクション
    @objc func pushBignnerButton(sender: UIButton){
        let vc = BiginnerViewController(titleName: "Biginner")
        navigationController?.pushViewController(vc, animated: true)
    }
    //    中級者ボタン押した時のアクション
    @objc func pushIntermediateButton(sender: UIButton){
        let vc = IntermediateViewController(titleName: "Intermediate")
        navigationController?.pushViewController(vc, animated: true)
    }
    //    上級者ボタン押した時のアクション
    @objc func pushAdvancedButton(sender: UIButton){
        let vc = AdvancedViewController(titleName: "Advanced")
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
    
    //大きい画像などのメモリ解放
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


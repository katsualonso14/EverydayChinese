//メインページ
import UIKit

class CategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Category"
        //    初心者ボタン
        let button:UIButton = UIButton()
        self.view.addSubview(button)
        //Autosizingのレイアウトの仕組みをAuto Layoutに変換するかどうかを設定するフラグを既存がオンなのでfalse(オフ)に設定
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .yellow
        //connstraitでlayoutを調整する
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        button.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
        button.setTitle("初心者", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(pushBignnerButton), for: .touchUpInside)
        button.layer.cornerRadius = 20.0
        button.layer.masksToBounds = true
        //    中級者ボタン
        let intermediateButton:UIButton = UIButton()
        self.view.addSubview(intermediateButton)
        intermediateButton.translatesAutoresizingMaskIntoConstraints = false
        intermediateButton.backgroundColor = .orange
        //connstraitでlayoutを調整する
        intermediateButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 50).isActive = true
        intermediateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        intermediateButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        intermediateButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        intermediateButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
        intermediateButton.setTitle("中級者", for: .normal)
        intermediateButton.setTitleColor(.black, for: .normal)
        intermediateButton.addTarget(self, action: #selector(pushIntermediateButton), for: .touchUpInside)
        intermediateButton.layer.cornerRadius = 20.0
        intermediateButton.layer.masksToBounds = true
        //    上級者ボタン
        let advancedButton:UIButton = UIButton()
        self.view.addSubview(advancedButton)
        advancedButton.translatesAutoresizingMaskIntoConstraints = false
        advancedButton.backgroundColor = .blue
        //connstraitでlayoutを調整する
        advancedButton.topAnchor.constraint(equalTo: intermediateButton.bottomAnchor, constant: 50).isActive = true
        advancedButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        advancedButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        advancedButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        advancedButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
        advancedButton.setTitle("上級者", for: .normal)
        advancedButton.setTitleColor(.black, for: .normal)
        advancedButton.addTarget(self, action: #selector(pushAdvancedButton), for: .touchUpInside)
        advancedButton.layer.cornerRadius = 20.0
        advancedButton.layer.masksToBounds = true
        self.view.addSubview(advancedButton)
        
    }
//    初心者ボタン押した時のアクション
    @objc func pushBignnerButton(sender: UIButton){
        let vc = BiginnerViewController(titleName: "Biginner")
        navigationController?.pushViewController(vc, animated: true)
    }
    //    中級者ボタン押した時のアクション
    @objc func pushIntermediateButton(sender: UIButton){
        let vc2 = IntermediateViewController(titleName: "Intermediate")
        navigationController?.pushViewController(vc2, animated: true)
    }
    //    上級者ボタン押した時のアクション
    @objc func pushAdvancedButton(sender: UIButton){
        let vc3 = AdvancedViewController(titleName: "Advanced")
        navigationController?.pushViewController(vc3, animated: true)   }
    
    //大きい画像などのメモリ解放
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

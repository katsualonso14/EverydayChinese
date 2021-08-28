//メインページ
import UIKit

class CategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        biginnerButton()
        intermediateButton()
        advancedButton()
        navigationItem.title = "Category"
        
        
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
    //    初心者ボタン
    func biginnerButton() {
        
        let button:UIButton = UIButton(frame: CGRect(x: 70, y: 150, width: 300, height: 150))
        button.backgroundColor = .yellow
        button.setTitle("初心者", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(pushBignnerButton), for: .touchUpInside)
        button.layer.cornerRadius = 20.0
        button.layer.masksToBounds = true
        self.view.addSubview(button)

    }
    //    中級者ボタン
    func intermediateButton() {
        
        let button:UIButton = UIButton(frame: CGRect(x: 70, y: 350, width: 300, height: 150))
        button.backgroundColor = .orange
        button.setTitle("中級者", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(pushIntermediateButton), for: .touchUpInside)
        button.layer.cornerRadius = 20.0
        button.layer.masksToBounds = true
        self.view.addSubview(button)

    }
    //    上級者ボタン
    func advancedButton() {
        
        let button:UIButton = UIButton(frame: CGRect(x: 70, y: 550, width: 300, height: 150))
        button.backgroundColor = .blue
        button.setTitle("上級者", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(pushAdvancedButton), for: .touchUpInside)
        button.layer.cornerRadius = 20.0
        button.layer.masksToBounds = true
        self.view.addSubview(button)

    }
    //大きい画像などのメモリ解放
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

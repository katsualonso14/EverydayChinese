//メインページ
import UIKit

class CategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        biginnerButton()
        intermediateButton()
        advancedButton()
        
    }
    
    @objc func pushBignnerButton(sender: UIButton){
        //       Biginner画面遷移
        let biginnerViewController = BiginnerViewController.init()
        //        全画面セット
        //        biginnerViewController.modalPresentationStyle = .fullScreen
        present(biginnerViewController, animated: true, completion: nil)
    }
    @objc func pushIntermediateButton(sender: UIButton){
        //Intermediate画面遷移
        let intermediateViewController = IntermediateViewController.init()
        present(intermediateViewController, animated: true, completion: nil)
    }
    @objc func pushAdvancedButton(sender: UIButton){
        //Advanced画面遷移
        let advancedViewController = AdvancedViewController.init()
        present(advancedViewController, animated: true, completion: nil)    }

    func biginnerButton() {
        
        let button:UIButton = UIButton(frame: CGRect(x: 70, y: 150, width: 300, height: 150))
        button.backgroundColor = .yellow
        button.setTitle("初心者", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(pushBignnerButton), for: .touchDown)
        button.layer.cornerRadius = 20.0
        button.layer.masksToBounds = true
        self.view.addSubview(button)

    }
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

//メインページ
import UIKit

class categoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        biginnerButton()
        intermediateButton()
        advancedButton()
        
    }

    @objc func pushBignnerButton(sender: UIButton){
        print("BignnerButton pushed.")
    }
    @objc func pushIntermediateButton(sender: UIButton){
        print("IntermediateButton pushed.")
    }
    @objc func pushAdvancedButton(sender: UIButton){
        print("AdvancedButton pushed.")
    }

    func biginnerButton() {
        
        let button:UIButton = UIButton(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.height / 4))
        button.backgroundColor = .blue
        button.setTitle("初心者", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(pushBignnerButton), for: .touchUpInside)
        self.view.addSubview(button)

    }
    func intermediateButton() {
        
        let button:UIButton = UIButton(frame: CGRect(x: 0, y: 300, width: self.view.frame.width, height: self.view.frame.height / 4))
        button.backgroundColor = .orange
        button.setTitle("中級者", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(pushIntermediateButton), for: .touchUpInside)
        self.view.addSubview(button)

    }
    func advancedButton() {
        
        let button:UIButton = UIButton(frame: CGRect(x: 0, y: 550, width: self.view.frame.width, height: self.view.frame.height / 4))
        button.backgroundColor = .yellow
        button.setTitle("上級者", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(pushAdvancedButton), for: .touchUpInside)
        self.view.addSubview(button)

    }
    //大きい画像などのメモリ解放
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


import Foundation
import UIKit

class DescriptionView: UIView {
    let imageView = UIImageView()
    let button = UIButton(type: .system)
    let label = UILabel()
    let checkBoxLabel = UILabel()
    let descriptionCheckBox = UIImageView()
    // QuickMemoかPhraseStoreかの判別フラグ
    var isQuickMemo = true
    // 説明ダイアログ次回以降非表示フラグ(UserDefaultsで管理)
    var isDescription: Bool {
        return UserDefaults.standard.bool(forKey: "isDescription")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 12
        setupView()
    }
    
    func setupView() {
        // 画像
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 20, y: 20, width: 250, height: 150)
        addSubview(imageView)

        // 説明文
        label.frame = CGRect(x: 20, y: 180, width: 280, height: 20)
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        addSubview(label)
        
        // チェックボックスの説明
        checkBoxLabel.text = "Do not show this message again."
        checkBoxLabel.frame = CGRect(x: 5, y: 260, width: 250, height: 20)
        checkBoxLabel.font = UIFont.systemFont(ofSize: 15)
        checkBoxLabel.textColor = .systemGray
        addSubview(checkBoxLabel)
        
        // 起動時に説明ダイアログを表示するかどうかのチェックボックス
        descriptionCheckBox.frame = CGRect(x: 180, y: 260, width: 150, height: 30)
        descriptionCheckBox.contentMode = .scaleAspectFit
        descriptionCheckBox.isUserInteractionEnabled = true
        addSubview(descriptionCheckBox)
        
        //チェックボックスのアクション
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckBox))
        descriptionCheckBox.addGestureRecognizer(gesture)

        // 閉じるボタン
        button.backgroundColor = AppColors.appMainColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(changePage), for: .touchUpInside)
        button.frame = CGRect(x: 20, y: 300, width: 250, height: 40)
        addSubview(button)
        
        updateViewContent()
    }
    
    func updateViewContent() {
        imageView.image = isQuickMemo ? UIImage(named: "Quick Memo Sample") : UIImage(named: "PhraseStore Sample")
        
        label.text = isQuickMemo ?
        "You can write down words you don't understand or are curious about in your daily life quickly and easily."
        : "You can save words and sentences that you want to remember and situations when you find them in PhraseStore."
        label.sizeToFit()
        
        button.setTitle(isQuickMemo ? "Next" : "Close", for: .normal)
        
        updateCheckBox()
    }
    
    func updateCheckBox() {
        descriptionCheckBox.image = isDescription ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
    }
    
    @objc func changePage() {
        if isQuickMemo {
            isQuickMemo = false
        } else {
            self.removeFromSuperview()
        }
        updateViewContent()
    }
    
    @objc func didTapCheckBox() {
        // チェックボックスの状態を切り替え
        let newState = !UserDefaults.standard.bool(forKey: "isDescription")
        UserDefaults.standard.set(newState, forKey: "isDescription")
        updateCheckBox()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

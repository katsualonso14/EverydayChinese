
import Foundation
import UIKit

class DescriptionView: UIView {
    let imageView = UIImageView()
    let button = UIButton(type: .system)
    let label = UILabel()
    // QuickMemoかPhraseStoreかの判別フラグ
    var isQuickMemo = true

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
        
        // 閉じるボタン
        button.backgroundColor = AppColors.appMainColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(changePage), for: .touchUpInside)
        button.frame = CGRect(x: 20, y: 250, width: 250, height: 40)
        addSubview(button)
        
        updateViewContent()
    }
    
    func updateViewContent() {
        imageView.image = isQuickMemo ? UIImage(named: "Quick Memo Sample") : UIImage(named: "PhraseStore Sample")
        
        label.text = isQuickMemo ?
        "You can write down words you don't understand or are curious about in your daily life quickly and easily."
        : "You can save words and sentences that you want to remember."
        label.sizeToFit()
        
        button.setTitle(isQuickMemo ? "Next" : "Close", for: .normal)
    }
    
    @objc func changePage() {
        if isQuickMemo {
            isQuickMemo = false
        } else {
            self.removeFromSuperview()
        }
        // Refresh the view with updated content
        updateViewContent()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

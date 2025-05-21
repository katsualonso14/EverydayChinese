
import Foundation
import UIKit

//TODO: Fix Strings for localization
class DescriptionView: UIView {
    let imageView = UIImageView()
    let button = UIButton(type: .system)
    let label = UILabel()
    let checkBoxLabel = UILabel()
    let descriptionCheckBox = UIImageView()
    let closeButton = UIButton()
    // QuickMemoかPhraseStoreかの判別フラグ
    //TODO: VCごとに可変できるように対応する
    var discriptNumber: Int
    // 説明ダイアログ次回以降非表示フラグ(UserDefaultsで管理)
    var isDescription: Bool {
        return UserDefaults.standard.bool(forKey: "isDescription")
    }
    override init(frame: CGRect) {
        self.discriptNumber = 1
        super.init(frame: frame)
        self.backgroundColor = AppColors.backgroundColorCheckMode
        self.layer.cornerRadius = 12
        NotificationCenter.default.addObserver(self, selector: #selector(checkNumber), name: NSNotification.Name("addDescription"), object: nil)
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
        label.textColor = AppColors.textColor
        addSubview(label)
        
        // チェックボックスの説明
        checkBoxLabel.text = NSLocalizedString("dicript_check_box_label", comment: "")
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

        // 画面切り替えボタン
        button.backgroundColor = AppColors.appMainColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(changePage), for: .touchUpInside)
        button.frame = CGRect(x: 20, y: 300, width: 250, height: 40)
        addSubview(button)
        
        //閉じるボタン
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .systemGray
        closeButton.frame = CGRect(x: 270, y: 0, width: 30, height: 30)
        closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        addSubview(closeButton)
        
        updateViewContent()
    }
    
    func updateViewContent() {
        imageView.image = discriptNumber == 1 ? UIImage(named: "Quick Memo Sample") :
        discriptNumber == 2 ? UIImage(named: "Add PhraseStore from Quick Memo") :
        discriptNumber == 3 ? UIImage(named: "PhraseStore Sample") : UIImage(named: "Memo sample")
        
        switch discriptNumber {
        case 1:
            label.text = NSLocalizedString("discript_text_1", comment: "")
        case 2:
            label.text = NSLocalizedString("discript_text_2", comment: "")
        case 3:
            label.text = NSLocalizedString("discript_text_3", comment: "")
        default:
            label.text = NSLocalizedString("discript_text_default", comment: "")
        }

        label.sizeToFit()

        button.setTitle(
            discriptNumber == 4 ? NSLocalizedString("close", comment: "") : NSLocalizedString("next", comment: ""),
            for: .normal)
        updateCheckBox()
    }
    
    func updateCheckBox() {
        descriptionCheckBox.image = isDescription ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
    }
    
    @objc func changePage() {
        if discriptNumber == 1 {
            discriptNumber = 2
        } else if discriptNumber == 2 {
            discriptNumber = 3
        } else if discriptNumber == 3 {
            discriptNumber = 4
        } else {
            self.removeFromSuperview()
        }
        updateViewContent()
    }
    // チェックボックスの状態を切り替え
    @objc func didTapCheckBox() {
        let newState = !UserDefaults.standard.bool(forKey: "isDescription")
        UserDefaults.standard.set(newState, forKey: "isDescription")
        updateCheckBox()
    }
    
    @objc func closeModal() {
        self.removeFromSuperview()
    }
    // 初期表示画面のフラグチェック
    @objc func checkNumber(_ notification: Notification) {
        if let userInfo = notification.userInfo,
           let number = userInfo["discriptNumber"] as? Int {
            discriptNumber = number
        }
        updateViewContent()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

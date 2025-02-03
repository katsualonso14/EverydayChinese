
import Foundation
import UIKit

class DescriptionView: UIView {
    let imageView = UIImageView()
    let closeButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 12

        // 画像
        imageView.image = UIImage(named: "Pharases Sample")
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 20, y: 20, width: 250, height: 150)
        addSubview(imageView)

        // 説明文
        let label = UILabel()
        label.text = "You can write down words you don't understand or are curious about in your daily life quickly and easily."
        label.frame = CGRect(x: 20, y: 180, width: 280, height: 20)
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.sizeToFit()
        addSubview(label)
        
        // 閉じるボタン
        closeButton.setTitle("Close", for: .normal)
        closeButton.backgroundColor = AppColors.appMainColor
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.layer.cornerRadius = 10
        closeButton.layer.masksToBounds = true
        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        closeButton.frame = CGRect(x: 20, y: 250, width: 250, height: 40)
        addSubview(closeButton)
    }

    @objc func closeView() {
        self.removeFromSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

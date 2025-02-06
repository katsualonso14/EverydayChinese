
import Foundation
import UIKit

enum AppColors {
    static let textColor = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return .white
        default:
            return .black
        }
    }
    // 背景色をダークモードなら黒, ライトモードなら白に設定
    static let backgroundColorCheckMode = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return .black
        default:
            return .white
        }
    }
    
    static let appMainColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
}




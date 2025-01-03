
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
}




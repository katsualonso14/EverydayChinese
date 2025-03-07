import Foundation
import UIKit


class CheckNotifController: UIViewController {
    
    //　通知によって画面遷移ページを変更する
    func navigateToPage(navController: UINavigationController, page: String) {
        switch page {
        case "greetings":
            let vc = GreetingsViewController(titleName: "Greetings")
            navController.pushViewController(vc, animated: true)
        case "personal":
            let vc = PersonalPronounsViewController(titleName: "Personal Pronouns")
            navController.pushViewController(vc, animated: true)
        case "demonstrative":
            let vc = DemonstrativePronounsViewController(titleName: "Demonstrative Pronouns")
            navController.pushViewController(vc, animated: true)
        case "interrogative":
            let vc = InterrogativePronounsViewController(titleName: "Interrogative Pronouns")
            navController.pushViewController(vc, animated: true)
        case "advanced":
            let vc = DailyTalkViewController(titleName: "Advanced")
            navController.pushViewController(vc, animated: true)
        case "trip":
            let vc = TripViewController(titleName: "Trip")
            navController.pushViewController(vc, animated: true)
        case "restaurant":
            let vc = RestaurantViewController(titleName: "Restaurant")
            navController.pushViewController(vc, animated: true)
        case "drama":
            let vc = DramaViewController(titleName: "Drama")
            navController.pushViewController(vc, animated: true)
        default:
            break
        }
        
    }
}

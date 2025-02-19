import Foundation
import UIKit


class CheckNotifController: UIViewController {
    
    //　通知によって画面遷移ページを変更する
    func navigateToPage(navController: UINavigationController, page: String) {
        switch page {
        case "greetings":
            let greetingsViewController = GreetingsViewController(titleName: "Greetings")
            navController.pushViewController(greetingsViewController, animated: true)
        case "intermediate":
            let intermediateViewController = PronounsViewController(titleName: "Intermediate")
            navController.pushViewController(intermediateViewController, animated: true)
        case "advanced":
            let advancedViewController = DailyConversationViewController(titleName: "Advanced")
            navController.pushViewController(advancedViewController, animated: true)
        case "trip":
            let tripViewController = TripViewController(titleName: "Trip")
            navController.pushViewController(tripViewController, animated: true)
        case "restaurant":
            let restaurantViewController = RestaurantViewController(titleName: "Restaurant")
            navController.pushViewController(restaurantViewController, animated: true)
        case "drama":
            let dramaViewController = DramaViewController(titleName: "Drama")
            navController.pushViewController(dramaViewController, animated: true)
        default:
            break
        }
        
    }
}

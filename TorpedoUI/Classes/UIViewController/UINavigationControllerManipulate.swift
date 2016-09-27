import Foundation
import UIKit

public extension UINavigationController {

    public func popToViewControllerWithClass<T:UIViewController>(_ type: T.Type, animated: Bool) -> [UIViewController] {
        let controllers = viewControllers.filter(ofType: type)
        if controllers.count == 0 {
            return []
        }
        return popToViewController(controllers.first!, animated: animated)!
    }

}

import Foundation
import UIKit

enum UIViewSorterError: Error {
    case viewHasNoSuperview
}

open class UIViewSorter {

    open class func sortViews<T:UIView>(_ views: [T]) throws -> [T] {
        return views.sorted {
            (first, second) -> Bool in
            return try! isViewBefore(first, secondView: second);
        }
    }

    open class func isViewBefore(_ firstView: UIView, secondView: UIView) throws -> Bool {
        guard firstView.superview != nil && secondView.superview != nil else {
            throw UIViewSorterError.viewHasNoSuperview
        }
        let firstFrame = firstView.superview!.convert(firstView.frame, to: nil)
        let secondFrame = secondView.superview!.convert(secondView.frame, to: nil)
        if firstFrame.origin.y < secondFrame.origin.y {
            return true
        }
        return firstFrame.origin.x < secondFrame.origin.x
    }

}

import Foundation
import UIKit

public extension UIView {

    func removeAllSubviews() {
        var subviewsCopy: [UIView] = []
        subviewsCopy.append(contentsOf: subviews)
        for view in subviewsCopy {
            view.removeFromSuperview()
        }
    }
    
    func isAnySuperviewThisView(_ view: UIView) -> Bool {
        if superview == nil {
            return false
        }
        if superview == view {
            return true
        }
        return superview!.isAnySuperviewThisView(view)
    }

    func filterSubviewsWithType<T:UIView>(_ type: T.Type) throws -> [T] {
        var results: [T] = []
        let subviewsWithClass: [T] = subviews.filter(ofType: type)
        results.append(contentsOf: subviewsWithClass)
        for subview: UIView in subviews {
            let subSubviews: [T] = try subview.filterSubviewsWithType(type)
            results.append(contentsOf: subSubviews)
        }
        return try! UIViewSorter.sortViews(results)
    }

    func textInputSubviews() throws -> [UIView] {
        let textFields = try filterSubviewsWithType(UITextField.self)
        let respondingTextFields = filterRespondingViews(textFields)
        let textViews = try filterSubviewsWithType(UITextView.self)
        let respondingTextViews = filterRespondingViews(textViews)
        var allResponders = respondingTextViews
        allResponders.append(contentsOf: respondingTextFields)
        return try! UIViewSorter.sortViews(allResponders)
    }

    func filterRespondingViews(_ responders: [UIView]) -> [UIView] {
        return responders.filter({
            (element) -> Bool in
            return element.canBecomeFirstResponder
        })
    }

}

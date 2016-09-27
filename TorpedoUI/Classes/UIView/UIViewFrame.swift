import Foundation
import UIKit

enum UIViewFrameError: Error {
    case scaleFactorBelowZero
}

public extension UIView {

    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var myFrame: CGRect = frame
            myFrame.origin.x = newValue
            frame = myFrame
        }
    }

    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var myFrame: CGRect = frame
            myFrame.origin.y = newValue
            frame = myFrame

        }
    }

    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            var myFrame: CGRect = frame
            myFrame.size.width = newValue
            frame = myFrame
        }
    }

    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            var myFrame: CGRect = frame
            myFrame.size.height = newValue
            frame = myFrame

        }
    }

    public func expandWidth(_ extraWidth: CGFloat) {
        width = width + extraWidth
    }

    public func expandHeight(_ extraHeight: CGFloat) {
        height = height + extraHeight
    }

    public func stretchToFillSuperview(_ margin: CGFloat = 0.0) {
        stretchToLeft(margin)
        stretchToTop(margin)
        stretchToRight(margin)
        stretchToBottom(margin)
    }

    public func stretchToLeft(_ margin: CGFloat = 0.0) {
        guard superview != nil else {
            return
        }
        let difference = marginToLeft() - margin
        alignLeft(margin)
        expandWidth(difference)
    }

    public func stretchToTop(_ margin: CGFloat = 0.0) {
        guard superview != nil else {
            return
        }
        let difference = marginToTop() - margin
        alignTop(margin)
        expandHeight(difference)
    }

    public func stretchToRight(_ margin: CGFloat = 0.0) {
        guard superview != nil else {
            return
        }
        let difference = marginToRight() - margin
        expandWidth(difference)
    }

    public func stretchToBottom(_ margin: CGFloat = 0.0) {
        guard superview != nil else {
            return
        }
        let difference = marginToBottom() - margin
        expandHeight(difference)
    }

    public func alignLeft(_ margin: CGFloat = 0.0) {
        x = margin
    }

    public func marginToLeft() -> CGFloat {
        return x
    }

    public func alignTop(_ margin: CGFloat = 0.0) {
        y = margin
    }

    public func marginToTop() -> CGFloat {
        return y
    }

    public func alignRight(_ margin: CGFloat = 0.0) {
        guard superview != nil else {
            return
        }
        let superviewWidth = superview!.width
        x = superviewWidth - width - margin
    }

    public func marginToRight() -> CGFloat {
        return superview!.width - width - x
    }

    public func alignBottom(_ margin: CGFloat = 0.0) {
        guard superview != nil else {
            return
        }
        let superviewHeight: CGFloat = superview!.height
        y = superviewHeight - height - margin
    }

    public func marginToBottom() -> CGFloat {
        return superview!.height - height - y
    }

    public func alignLeftOfView(_ siblingView: UIView, margin: CGFloat = 0.0) {
        //TODO: if views have common ancestor. We can calc the position by referring to frame in respect to that view. Then do the calc
        let newX = siblingView.x - width - margin
        x = newX
    }

    public func alignAboveView(_ siblingView: UIView, margin: CGFloat = 0.0) {
        let newY = siblingView.y - height - margin
        y = newY
    }

    public func alignRightOfView(_ siblingView: UIView, margin: CGFloat = 0.0) {
        let newX = siblingView.x + siblingView.width + margin
        x = newX
    }

    public func alignBelowView(_ siblingView: UIView, margin: CGFloat = 0.0) {
        let newY = siblingView.y + siblingView.height + margin
        y = newY
    }

    public func moveLeft(_ points: CGFloat) {
        x = x - points
    }

    public func moveUp(_ points: CGFloat) {
        y = y - points
    }

    public func moveRight(_ points: CGFloat) {
        x = x + points
    }

    public func moveDown(_ points: CGFloat) {
        y = y + points
    }

    public func centerInSuperview() {
        centerHorizontally()
        centerVertically()
    }

    public func centerHorizontally() {
        guard superview != nil else {
            return
        }
        center = CGPoint(x: superview!.width / 2, y: center.y)
    }

    public func centerVertically() {
        guard superview != nil else {
            return
        }
        center = CGPoint(x: center.x, y: superview!.height / 2)
    }

    public func scale(_ scale: CGFloat) throws {
        guard scale > 0 else {
            throw UIViewFrameError.scaleFactorBelowZero
        }
        let currentCenter = center
        width = width * scale
        height = height * scale
        center = currentCenter
    }
    
    public func makeRound() {
        self.layer.cornerRadius = width/2.0
    }

}

import UIKit

public extension UIViewController {
    
    private static var isFinishedSwizzling = false
    
    private struct AssociatedKeys {
        static var IsVisible = "swifter_isVisible"
        static var DidAppearFirstTimeDone = "swifter_didAppearFirstTimeDone"
        static var WillAppearFirstTimeDone = "swifter_willAppearFirstTimeDone"
    }
    
    public var isVisible: Bool {
        return isVisibleToggle
    }

    public var isFirstWillAppear: Bool {
        return !willAppearFirstTimeDone
    }

    public var isFirstDidAppear: Bool {
        return !didAppearFirstTimeDone
    }
    
    static func configure_torpedoui_visibility() {
        
        if !isFinishedSwizzling {
            isFinishedSwizzling = true
            
            //View Controller Visibility
            self.swizzleSelectorsInClass(self, originalSelector:
                #selector(UIViewController.viewWillAppear(_:)), swizzledSelector: #selector(UIViewController.swifter_viewWillAppear(_:)))
            self.swizzleSelectorsInClass(self, originalSelector:
                #selector(UIViewController.viewDidAppear(_:)), swizzledSelector: #selector(UIViewController.swifter_viewDidAppear(_:)))
            self.swizzleSelectorsInClass(self, originalSelector:
                #selector(UIViewController.viewDidDisappear(_:)), swizzledSelector: #selector(UIViewController.swifter_viewDidDisappear(_:)))

        }
    }
    
    private static func swizzleSelectorsInClass(_ cls: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(cls, originalSelector)
        let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector)
        let didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }
    
    // Visibility
    
    func swifter_viewWillAppear(_ animated: Bool) {
        swifter_viewWillAppear(animated)
        willAppearFirstTimeDone = true
    }
    
    func swifter_viewDidAppear(_ animated: Bool) {
        swifter_viewDidAppear(animated)
        isVisibleToggle = true
        didAppearFirstTimeDone = true
    }
    
    func swifter_viewDidDisappear(_ animated: Bool) {
        swifter_viewDidDisappear(animated)
        isVisibleToggle = false
    }
    
    private var isVisibleToggle: Bool {
        get {
            let existingValue = objc_getAssociatedObject(self, &AssociatedKeys.IsVisible)
            if let value = existingValue as? Bool {
                return value
            }
            return false
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.IsVisible, newValue as Bool, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var willAppearFirstTimeDone: Bool {
        get {
            let existingValue = objc_getAssociatedObject(self, &AssociatedKeys.WillAppearFirstTimeDone)
            if let value = existingValue as? Bool {
                return value
            }
            return false
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.WillAppearFirstTimeDone, newValue as Bool, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var didAppearFirstTimeDone: Bool {
        get {
            let existingValue = objc_getAssociatedObject(self, &AssociatedKeys.DidAppearFirstTimeDone)
            if let value = existingValue as? Bool {
                return value
            }
            return false
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.DidAppearFirstTimeDone, newValue as Bool, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

}


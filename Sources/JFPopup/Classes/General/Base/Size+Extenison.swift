//
//  Size+Extenison.swift
//  Example
//
//  Created by JerryFans on 2021/8/4.
//

import UIKit
extension Bool: JFCompatible {}
public extension JF where Base == Bool {
    static func isBangsiPhone() -> Bool {
       var isBangs = false
        if #available(iOS 11.0, *) {
            isBangs = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0 > 0.0
        }
       return isBangs
    }
}

extension CGFloat: JFCompatible {}
public extension JF where Base == CGFloat {
    
    static func navigationBarHeight() -> CGFloat {
        return self.safeAreaInsets().top + 44.0
    }
    
    static func statusBarHeight() -> CGFloat {
        return self.safeAreaInsets().top
    }
    
    static func safeAreaBottomHeight() -> CGFloat {
        return self.safeAreaInsets().bottom
    }
    
    static func safeAreaInsets() -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.windows.first?.safeAreaInsets ?? .zero
        } else {
            return .zero
        }
    }
}

extension CGSize: JFCompatible {}
public extension JF where Base == CGSize {
    
    private var version_keyWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            let windowScenes = UIApplication.shared.connectedScenes.filter ({ screen in
                guard let wc = screen as? UIWindowScene, wc.activationState != .unattached else {
                    return false
                }
                return true
            }).map { $0 as! UIWindowScene }
            for wc in windowScenes {
                if let s = wc.delegate as? UIWindowSceneDelegate, let sw = s.window, let ssw = sw {
                    return ssw
                }
                if #available(iOS 15.0, *) {
                    if let wck = wc.keyWindow {
                        return wck
                    }
                }
                if let wck = wc.windows.filter({ $0.isKeyWindow }).first {
                    return wck
                }
            }
            return nil
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    static func screenBounds() -> CGRect {
        if let w = CGSize().jf.version_keyWindow {
            return w.frame
        }
        return UIScreen.main.bounds
    }
    
    static func screenSize() -> CGSize {
        return screenBounds().size
    }
    
    static func screenWidth() -> CGFloat {
        return screenSize().width
    }
    
    static func screenHeight() -> CGFloat {
        return screenSize().height
    }
}

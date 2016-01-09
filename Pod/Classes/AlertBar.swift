//
//  AlertBar.swift
//
//  Created by Jin Sasaki on 2016/01/01.
//  Copyright © 2016年 Jin Sasaki. All rights reserved.
//

import UIKit

public enum AlertBarType {
    case Success
    case Error
    case Notice
    case Warning
    case Info
    case Custom(UIColor, UIColor)
    
    var backgroundColor: UIColor {
        get {
            switch self {
            case .Success:
                return AlertBarHelper.UIColorFromRGB(0x4CAF50)
            case .Error:
                return AlertBarHelper.UIColorFromRGB(0xf44336)
            case .Notice:
                return AlertBarHelper.UIColorFromRGB(0x2196F3)
            case .Warning:
                return AlertBarHelper.UIColorFromRGB(0xFFC107)
            case .Info:
                return AlertBarHelper.UIColorFromRGB(0x009688)
            case .Custom(let backgroundColor, _):
                return backgroundColor
            }
        }
    }
    var textColor: UIColor {
        get {
            switch self {
            case .Custom(_, let textColor):
                return textColor
            default:
                return AlertBarHelper.UIColorFromRGB(0xFFFFFF)
            }
        }
    }
}

public class AlertBar: UIView {
    static var alertBars: [AlertBar] = []
    
    let messageLabel = UILabel()

    required public init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        messageLabel.frame = CGRect(x: 2, y: 2, width: frame.width - 4, height: frame.height - 4)
        messageLabel.font = UIFont.systemFontOfSize(12)
        self.addSubview(messageLabel)
    }
    
    public class func show(type: AlertBarType, message: String, duration: Double = 2, completion: (() -> Void)? = nil) {
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let alertBar = AlertBar(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: statusBarHeight))
        alertBar.messageLabel.text = message
        alertBar.backgroundColor = type.backgroundColor
        alertBar.messageLabel.textColor = type.textColor
        AlertBar.alertBars.append(alertBar)
        
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: statusBarHeight))
        window.windowLevel = UIWindowLevelStatusBar + 1 + CGFloat(AlertBar.alertBars.count)
        window.addSubview(alertBar)
        window.makeKeyAndVisible()
        
        alertBar.transform = CGAffineTransformMakeTranslation(0, -statusBarHeight)
        UIView.animateWithDuration(0.2,
            animations: { () -> Void in
                alertBar.transform = CGAffineTransformIdentity
            }, completion: { _ in
                UIView.animateWithDuration(0.2,
                    delay: duration,
                    options: .CurveEaseInOut,
                    animations: { () -> Void in
                        alertBar.transform = CGAffineTransformMakeTranslation(0, -statusBarHeight)
                    },
                    completion: { (animated: Bool) -> Void in
                        alertBar.removeFromSuperview()
                        if let index = AlertBar.alertBars.indexOf(alertBar) {
                            AlertBar.alertBars.removeAtIndex(index)
                        }
                        // To hold window instance
                        window.hidden = true
                        completion?()
                })
            })
    }
    
    public class func showError(error: NSError, duration: Double = 2, completion: (() -> Void)? = nil) {
        let code = error.code
        let localizedDescription = error.localizedDescription
        self.show(.Error, message: "(\(code)) " + localizedDescription)
    }
}

internal class AlertBarHelper {
    class func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
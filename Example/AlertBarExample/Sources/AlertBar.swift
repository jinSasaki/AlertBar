//
//  AlertBar.swift
//
//  Created by Jin Sasaki on 2016/01/01.
//  Copyright © 2016年 Jin Sasaki. All rights reserved.
//

import UIKit

public enum AlertBarType {
    case success
    case error
    case notice
    case warning
    case info
    case custom(UIColor, UIColor)
    
    var backgroundColor: UIColor {
        get {
            switch self {
            case .success:
                return UIColor(0x4CAF50)
            case .error:
                return UIColor(0xf44336)
            case .notice:
                return UIColor(0x2196F3)
            case .warning:
                return UIColor(0xFFC107)
            case .info:
                return UIColor(0x009688)
            case .custom(let backgroundColor, _):
                return backgroundColor
            }
        }
    }
    var textColor: UIColor {
        get {
            switch self {
            case .custom(_, let textColor):
                return textColor
            default:
                return UIColor(0xFFFFFF)
            }
        }
    }
}

open class AlertBar: UIView {
    open static var textAlignment: NSTextAlignment = .left
    static var alertBars: [AlertBar] = []
    
    let messageLabel = UILabel()

    required public init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        messageLabel.frame = CGRect(x: 2, y: 2, width: frame.width - 4, height: frame.height - 4)
        messageLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(messageLabel)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleRotate(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    dynamic fileprivate func handleRotate(_ notification: Notification) {
        self.removeFromSuperview()
        AlertBar.alertBars = []
    }
    
    open class func show(_ type: AlertBarType, message: String, duration: Double = 2, completion: (() -> Void)? = nil) {
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let alertBar = AlertBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: statusBarHeight))
        alertBar.messageLabel.text = message
        alertBar.messageLabel.textAlignment = AlertBar.textAlignment
        alertBar.backgroundColor = type.backgroundColor
        alertBar.messageLabel.textColor = type.textColor
        AlertBar.alertBars.append(alertBar)
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height

        let baseView = UIView(frame: UIScreen.main.bounds)
        baseView.isUserInteractionEnabled = false
        baseView.addSubview(alertBar)

        let window: UIWindow
        let orientation = UIApplication.shared.statusBarOrientation
        if orientation.isLandscape {
            window = UIWindow(frame: CGRect(x: 0, y: 0, width: height, height: width))
            let sign: CGFloat = orientation == .landscapeLeft ? -1 : 1
            let d = fabs(width - height) / 2
            baseView.transform = CGAffineTransform(rotationAngle: sign * CGFloat(M_PI) / 2).translatedBy(x: sign * d, y: sign * d)
        } else {
            window = UIWindow(frame: CGRect(x: 0, y: 0, width: width, height: height))
            if orientation == .portraitUpsideDown {
                baseView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
            }
        }
        window.isUserInteractionEnabled = false
        window.windowLevel = UIWindowLevelStatusBar + 1 + CGFloat(AlertBar.alertBars.count)
        window.addSubview(baseView)
        window.makeKeyAndVisible()
        
        alertBar.transform = CGAffineTransform(translationX: 0, y: -statusBarHeight)
        UIView.animate(withDuration: 0.2,
            animations: { () -> Void in
                alertBar.transform = CGAffineTransform.identity
            }, completion: { _ in
                UIView.animate(withDuration: 0.2,
                    delay: duration,
                    options: UIViewAnimationOptions(),
                    animations: { () -> Void in
                        alertBar.transform = CGAffineTransform(translationX: 0, y: -statusBarHeight)
                    },
                    completion: { (animated: Bool) -> Void in
                        alertBar.removeFromSuperview()
                        if let index = AlertBar.alertBars.index(of: alertBar) {
                            AlertBar.alertBars.remove(at: index)
                        }
                        // To hold window instance
                        window.isHidden = true
                        completion?()
                })
            })
    }
    
    open class func show(error: Error, duration: Double = 2, completion: (() -> Void)? = nil) {
        let code = (error as NSError).code
        let localizedDescription = error.localizedDescription
        self.show(.error, message: "(\(code)) " + localizedDescription, duration: duration, completion: completion)
    }
}

internal extension UIColor {
    convenience init(_ rgbValue: UInt) {
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

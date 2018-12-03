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
        switch self {
        case .success: return UIColor(0x4CAF50)
        case .error: return UIColor(0xf44336)
        case .notice: return UIColor(0x2196F3)
        case .warning: return UIColor(0xFFC107)
        case .info: return UIColor(0x009688)
        case .custom(let backgroundColor, _): return backgroundColor
        }
    }
    var textColor: UIColor {
        switch self {
        case .custom(_, let textColor): return textColor
        default: return UIColor(0xFFFFFF)
        }
    }
}

public final class AlertBar {
    public static let shared = AlertBar()
    private static let kWindowLevel: CGFloat = UIWindowLevelStatusBar + 1
    private var alertBarViews: [AlertBarView] = []
    private var options = Options(shouldConsiderSafeArea: true, isStretchable: false, textAlignment: .left)

    public struct Options {
        let shouldConsiderSafeArea: Bool
        let isStretchable: Bool
        let textAlignment: NSTextAlignment
        let font: UIFont

        public init(
            shouldConsiderSafeArea: Bool = true,
            isStretchable: Bool = false,
            textAlignment: NSTextAlignment = .left,
            font: UIFont = UIFont.systemFont(ofSize: 12.0)) {

            self.shouldConsiderSafeArea = shouldConsiderSafeArea
            self.isStretchable = isStretchable
            self.textAlignment = textAlignment
            self.font = font
        }
    }

    public func setDefault(options: Options) {
        self.options = options
    }

    public func show(type: AlertBarType, message: String, duration: TimeInterval = 2, options: Options? = nil, completion: (() -> Void)? = nil) {
        // Hide all before new one is shown.
        alertBarViews.forEach({ $0.hide() })

        let currentOptions = options ?? self.options

        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height

        let baseView = UIView(frame: UIScreen.main.bounds)
        let window: UIWindow
        let orientation = UIApplication.shared.statusBarOrientation
        let userInterfaceIdiom = UIDevice.current.userInterfaceIdiom
        if orientation.isLandscape {
            window = UIWindow(frame: CGRect(x: 0, y: 0, width: height, height: width))
            if userInterfaceIdiom == .phone {
                let sign: CGFloat = orientation == .landscapeLeft ? -1 : 1
                let d = fabs(width - height) / 2
                baseView.transform = CGAffineTransform(rotationAngle: sign * CGFloat.pi / 2).translatedBy(x: sign * d, y: sign * d)
            }
        } else {
            window = UIWindow(frame: CGRect(x: 0, y: 0, width: width, height: height))
            if userInterfaceIdiom == .phone && orientation == .portraitUpsideDown {
                baseView.transform = CGAffineTransform(rotationAngle: .pi)
            }
        }
        window.isUserInteractionEnabled = false
        window.windowLevel = AlertBar.kWindowLevel
        window.makeKeyAndVisible()
        baseView.isUserInteractionEnabled = false
        window.addSubview(baseView)

        let safeArea: UIEdgeInsets
        if #available(iOS 11.0, *) {
            safeArea = window.safeAreaInsets
        } else {
            safeArea = .zero
        }
        let alertBarView = AlertBarView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
        alertBarView.delegate = self
        alertBarView.backgroundColor = type.backgroundColor
        alertBarView.messageLabel.textColor = type.textColor
        alertBarView.messageLabel.text = message
        alertBarView.messageLabel.numberOfLines = currentOptions.isStretchable ? 0 : 1
        alertBarView.messageLabel.textAlignment = currentOptions.textAlignment
        alertBarView.messageLabel.font = currentOptions.font
        alertBarView.fit(safeArea: currentOptions.shouldConsiderSafeArea ? safeArea : .zero)
        alertBarViews.append(alertBarView)
        baseView.addSubview(alertBarView)

        let statusBarHeight: CGFloat = max(UIApplication.shared.statusBarFrame.height, safeArea.top)
        let alertBarHeight: CGFloat = max(statusBarHeight, alertBarView.frame.height)
        alertBarView.show(duration: 2, translationY: -alertBarHeight) {
            if let index = self.alertBarViews.index(of: alertBarView) {
                self.alertBarViews.remove(at: index)
            }
            // To hold window instance
            window.isHidden = true
            completion?()
        }
    }

    public func show(error: Error, duration: TimeInterval = 2, options: Options? = nil, completion: (() -> Void)? = nil) {
        let code = (error as NSError).code
        let localizedDescription = error.localizedDescription
        show(type: .error, message: "(\(code)) \(localizedDescription)", duration: duration, options: options, completion: completion)
    }
}

extension AlertBar: AlertBarViewDelegate {
    func alertBarViewHandleRotate(_ alertBarView: AlertBarView) {
        alertBarView.removeFromSuperview()
        alertBarViews.forEach({ $0.hide() })
        alertBarViews = []
   }
}

// MARK: - Static helpers

public extension AlertBar {
    public static func setDefault(options: Options) {
        shared.options = options
    }

    public static func show(type: AlertBarType, message: String, duration: TimeInterval = 2, options: Options? = nil, completion: (() -> Void)? = nil) {
        shared.show(type: type, message: message, duration: duration, options: options, completion: completion)
    }

    public static func show(error: Error, duration: TimeInterval = 2, options: Options? = nil, completion: (() -> Void)? = nil) {
        shared.show(error: error, duration: duration, options: options, completion: completion)
    }
}

protocol AlertBarViewDelegate: class {
    func alertBarViewHandleRotate(_ alertBarView: AlertBarView)
}

internal class AlertBarView: UIView {
    internal let messageLabel = UILabel()
    internal weak var delegate: AlertBarViewDelegate?

    private enum State {
        case showing
        case shown
        case hiding
        case hidden
    }

    private static let kMargin: CGFloat = 2
    private static let kAnimationDuration: TimeInterval = 0.2

    private var translationY: CGFloat = 0
    private var completion: (() -> Void)?
    private var state: State = .hidden

    required public init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let margin = AlertBarView.kMargin
        messageLabel.frame = CGRect(x: margin, y: margin, width: frame.width - margin*2, height: frame.height - margin*2)
        addSubview(messageLabel)

        NotificationCenter.default.addObserver(self, selector: #selector(self.handleRotate(_:)), name: .UIDeviceOrientationDidChange, object: nil)
    }

    func fit(safeArea: UIEdgeInsets) {
        let margin = AlertBarView.kMargin
        messageLabel.sizeToFit()
        messageLabel.frame.origin.x = margin + safeArea.left
        messageLabel.frame.origin.y = margin + safeArea.top
        messageLabel.frame.size.width = frame.size.width - margin*2 - safeArea.left - safeArea.right
        frame.size.height = messageLabel.frame.origin.y + messageLabel.frame.height + margin*2
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIDeviceOrientationDidChange, object: nil)
    }

    func show(duration: TimeInterval, translationY: CGFloat, completion: (() -> Void)?) {
        self.state = .showing
        self.translationY = translationY
        self.completion = completion

        transform = CGAffineTransform(translationX: 0, y: translationY)
        UIView.animate(
            withDuration: AlertBarView.kAnimationDuration,
            animations: { () -> Void in
                self.transform = .identity
        }, completion: { _ in
            self.state = .shown
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(duration))) {
                self.hide()
            }
        })
    }

    func hide() {
        guard state == .showing || state == .shown else {
            return
        }
        self.state = .hiding
        // Hide animation
        UIView.animate(
            withDuration: AlertBarView.kAnimationDuration,
            animations: { () -> Void in
                self.transform = CGAffineTransform(translationX: 0, y: self.translationY)
        },
            completion: { (animated: Bool) -> Void in
                self.removeFromSuperview()
                self.state = .hidden
                self.completion?()
                self.completion = nil
        })
    }

    @objc private func handleRotate(_ notification: Notification) {
        delegate?.alertBarViewHandleRotate(self)
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

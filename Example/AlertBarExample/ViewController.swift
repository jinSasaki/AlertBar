//
//  ViewController.swift
//  AlertBarExample
//
//  Created by Jin Sasaki on 2017/01/08.
//  Copyright © 2017年 sasakky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func tapSuccess(_ sender: AnyObject) {
        AlertBar.show(type: .success, message: "This is a Success message.")
    }

    @IBAction func tapError(_ sender: AnyObject) {
        AlertBar.show(error: NSError(domain: "Page not found", code: 404, userInfo: nil), duration: 3)
    }

    @IBAction func tapNotice(_ sender: AnyObject) {
        AlertBar.show(type: .notice, message: "This is a Notice message.", completion: { () -> Void in
            print("Noticed")
        })
    }

    @IBAction func tapWarning(_ sender: AnyObject) {
        AlertBar.show(type: .warning, message: "This is a Warning message.")
    }

    @IBAction func tapInfo(_ sender: AnyObject) {
        AlertBar.show(type: .info, message: "This is an Info message.", option: .init(shouldConsiderSafeArea: false, isStretchable: true, textAlignment: .right))
    }

    @IBAction func tapCustom(_ sender: AnyObject) {
        AlertBar.show(type: .custom(UIColor.lightGray, UIColor.black), message: "This is a Custom message. \nlong \nlong \nlong \nlong \nlong \nlong \nlong message", duration: 5, option: .init(isStretchable: true, textAlignment: .center))
    }

    override var prefersStatusBarHidden : Bool {
        return false
    }
}

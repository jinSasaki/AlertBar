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
        AlertBar.show(.success, message: "This is a Success message.")
    }

    @IBAction func tapError(_ sender: AnyObject) {
        AlertBar.show(error: NSError(domain: "Page not found", code: 404, userInfo: nil), duration: 3)
    }

    @IBAction func tapNotice(_ sender: AnyObject) {
        AlertBar.show(.notice, message: "This is a Notice message.", completion: { () -> Void in
            print("Noticed")
        })
    }

    @IBAction func tapWarning(_ sender: AnyObject) {
        AlertBar.show(.warning, message: "This is a Warning message.")
    }

    @IBAction func tapInfo(_ sender: AnyObject) {
        AlertBar.show(.info, message: "This is an Info message.")
    }

    @IBAction func tapCustom(_ sender: AnyObject) {
        AlertBar.show(.custom(UIColor.lightGray, UIColor.black), message: "This is a Custom message.", duration: 5)
    }

    override var prefersStatusBarHidden : Bool {
        return false
    }
}

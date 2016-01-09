//
//  ViewController.swift
//  AlertBar
//
//  Created by Jin Sasaki on 01/09/2016.
//  Copyright (c) 2016 Jin Sasaki. All rights reserved.
//

import UIKit
import AlertBar

class ViewController: UIViewController {
    
    @IBAction func tapSuccess(sender: AnyObject) {
        AlertBar.show(.Success, message: "This is a Success message.")
    }
    
    @IBAction func tapError(sender: AnyObject) {
        AlertBar.show(.Error, message: "This is an Error message.", duration: 3)
    }
    
    @IBAction func tapNotice(sender: AnyObject) {
        AlertBar.show(.Notice, message: "This is a Notice message.", completion: { () -> Void in
            print("Noticed")
        })
    }
    
    @IBAction func tapWarning(sender: AnyObject) {
        AlertBar.show(.Warning, message: "This is a Warning message.")
    }
    
    @IBAction func tapInfo(sender: AnyObject) {
        AlertBar.show(.Info, message: "This is an Info message.")
    }
    
    @IBAction func tapCustom(sender: AnyObject) {
        AlertBar.show(.Custom(UIColor.lightGrayColor(), UIColor.blackColor()), message: "This is a Custom message.", duration: 5)
    }
}
